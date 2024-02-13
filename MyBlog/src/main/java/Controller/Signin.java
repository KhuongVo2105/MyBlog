package Controller;

import DAO.DAO_User;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/signin")
public class Signin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("signin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email"), password = req.getParameter("password"), url = "";
        boolean err = false;

        // TODO: Validate email and password
        String id = DAO_User.getInstance().checkEnP(email, password);
        if (id.isEmpty()) {
            // TODO: Show error
            req.setAttribute("err", "Email or password is incorrect!");
            err = true;
        } else {
            User user = DAO_User.getInstance().select(new User(id));

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
            } else {
                // TODO: Show error
                req.setAttribute("err", "An error occurred!");
                err = true;
            }
        }

        if (!err) {
            url = "/index.jsp";
        } else {
            req.setAttribute("email", email);

            url = "/Signin.jsp";
        }
        getServletContext().getRequestDispatcher(url).forward(req, resp);
    }
}
