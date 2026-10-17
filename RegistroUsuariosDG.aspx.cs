using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Clase12_PrimeraPaginaWeb1
{
    /// <summary>
    /// Página de registro, consulta y eliminación de usuarios.
    /// Clase 12 - Mi primera página web.
    /// Daniela Paola Grajeda Sandoval
    /// </summary>
    public partial class RegistroUsuariosDG : System.Web.UI.Page
    {
        SqlConnection conexionDG = new SqlConnection(
            ConfigurationManager.ConnectionStrings["conexionBD"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorDG.Text = "";
            lblMensajeEliminarDG.Text = "";
            LeerDatosDG();
        }

        void LimpiarDG()
        {
            tbNombresDG.Text = "";
            tbApellidosDG.Text = "";
            tbFechaNacimientoDG.Text = "";
            tbUsuarioDG.Text = "";
            tbContraseniaDG.Text = "";
            tbConfirmarContraseniaDG.Text = "";
            lblErrorDG.Text = "";
        }

        protected void btnRegistrarDG_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(tbNombresDG.Text) ||
                string.IsNullOrWhiteSpace(tbApellidosDG.Text) ||
                string.IsNullOrWhiteSpace(tbFechaNacimientoDG.Text) ||
                string.IsNullOrWhiteSpace(tbUsuarioDG.Text) ||
                string.IsNullOrWhiteSpace(tbContraseniaDG.Text) ||
                string.IsNullOrWhiteSpace(tbConfirmarContraseniaDG.Text))
            {
                lblErrorDG.Text = "Ningún campo puede quedar vacío.";
                return;
            }

            if (tbContraseniaDG.Text != tbConfirmarContraseniaDG.Text)
            {
                lblErrorDG.Text = "Las contraseñas no coinciden.";
                return;
            }

            try
            {
                conexionDG.Open();

                SqlCommand cmdExisteDG = new SqlCommand(
                    "SELECT COUNT(*) FROM Usuarios WHERE Usuario = @Usuario", conexionDG);
                cmdExisteDG.Parameters.AddWithValue("@Usuario", tbUsuarioDG.Text);
                int existeDG = Convert.ToInt32(cmdExisteDG.ExecuteScalar());

                if (existeDG > 0)
                {
                    lblErrorDG.Text = "El usuario " + tbUsuarioDG.Text + " ya existe.";
                    return;
                }

                string patronDG = "clase12DG";
                SqlCommand cmdInsertDG = new SqlCommand(
                    "INSERT INTO Usuarios (Nombres, Apellidos, FechaNacimiento, Usuario, Contrasenia) " +
                    "VALUES (@Nombres, @Apellidos, @Fecha, @Usuario, EncryptByPassPhrase(@Patron, @Clave))", conexionDG);

                cmdInsertDG.Parameters.AddWithValue("@Nombres", tbNombresDG.Text);
                cmdInsertDG.Parameters.AddWithValue("@Apellidos", tbApellidosDG.Text);
                cmdInsertDG.Parameters.AddWithValue("@Fecha", tbFechaNacimientoDG.Text);
                cmdInsertDG.Parameters.AddWithValue("@Usuario", tbUsuarioDG.Text);
                cmdInsertDG.Parameters.AddWithValue("@Patron", patronDG);
                cmdInsertDG.Parameters.AddWithValue("@Clave", tbContraseniaDG.Text);

                cmdInsertDG.ExecuteNonQuery();
                LimpiarDG();
                lblErrorDG.CssClass = "d-block text-success small";
                lblErrorDG.Text = "Usuario registrado correctamente.";
            }
            catch (Exception ex)
            {
                lblErrorDG.Text = "Error al registrar: " + ex.Message;
            }
            finally
            {
                if (conexionDG.State == ConnectionState.Open)
                    conexionDG.Close();
            }

            LeerDatosDG();
        }

        void LeerDatosDG()
        {
            try
            {
                SqlCommand cmdLeerDG = new SqlCommand("SELECT Id, Nombres, Apellidos, FechaNacimiento, Usuario FROM Usuarios", conexionDG);
                SqlDataAdapter daDG = new SqlDataAdapter(cmdLeerDG);
                DataTable dtDG = new DataTable();
                daDG.Fill(dtDG);
                gvUsuariosDG.DataSource = dtDG;
                gvUsuariosDG.DataBind();
            }
            catch
            {
                // Error silencioso en la carga inicial
            }
        }

        protected void btnEliminarDG_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(tbEliminarDG.Text))
            {
                lblMensajeEliminarDG.CssClass = "d-block text-danger small mt-2";
                lblMensajeEliminarDG.Text = "Escribe el nombre de usuario a eliminar.";
                return;
            }

            try
            {
                conexionDG.Open();
                SqlCommand cmdEliminarDG = new SqlCommand(
                    "DELETE FROM Usuarios WHERE Usuario = @Usuario", conexionDG);
                cmdEliminarDG.Parameters.AddWithValue("@Usuario", tbEliminarDG.Text);
                int filasDG = cmdEliminarDG.ExecuteNonQuery();

                if (filasDG > 0)
                {
                    lblMensajeEliminarDG.CssClass = "d-block text-success small mt-2";
                    lblMensajeEliminarDG.Text = "Usuario eliminado correctamente.";
                    tbEliminarDG.Text = "";
                }
                else
                {
                    lblMensajeEliminarDG.CssClass = "d-block text-warning small mt-2";
                    lblMensajeEliminarDG.Text = "No se encontró el usuario.";
                }
            }
            catch (Exception ex)
            {
                lblMensajeEliminarDG.CssClass = "d-block text-danger small mt-2";
                lblMensajeEliminarDG.Text = "Error al eliminar: " + ex.Message;
            }
            finally
            {
                if (conexionDG.State == ConnectionState.Open)
                    conexionDG.Close();
            }

            LeerDatosDG();
        }
    }
}