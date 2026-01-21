package servlet;

import java.io.IOException;
import java.util.Objects; // これが重要！

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.User;
import dao.Dao; // これが重要！

@WebServlet("/UpdateUserServletAns")
public class UpdateUserServletAns extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword1 = request.getParameter("newPassword1");
        String newPassword2 = request.getParameter("newPassword2");

        HttpSession session = request.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;
        
        Dao dao = new Dao();
        User user = dao.getUserById(userId);

        if (user != null) {
            User newUser = new User();
            newUser.setId(userId);
            newUser.setName((name != null && !name.isBlank()) ? name : user.getName());

            if (Objects.equals(currentPassword, user.getPassword())
                    && newPassword1 != null && !newPassword1.isBlank()
                    && Objects.equals(newPassword1, newPassword2)) {
                newUser.setPassword(newPassword1);
            } else {
                newUser.setPassword(user.getPassword());
            }

            dao.updateUser(newUser);
            request.setAttribute("user", dao.getUserById(userId));
            request.getRequestDispatcher("./WEB-INF/jsp/updateUserAns.jsp").forward(request, response);
        }
    }
}