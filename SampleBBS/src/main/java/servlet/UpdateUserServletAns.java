package servlet;

import java.io.IOException;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.User;
import dao.Dao;

@WebServlet("/UpdateUserServletAns")
public class UpdateUserServletAns extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword1 = request.getParameter("newPassword1");
        String newPassword2 = request.getParameter("newPassword2");
        
        HttpSession session = request.getSession(false);
        String userId = (String) session.getAttribute("userId");
        Dao dao = new Dao();
        User user = dao.getUserById(userId);
        
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
        
        dao.updateUser(newUser); // ここでDaoを呼び出し
        request.setAttribute("user", dao.getUserById(userId));
        RequestDispatcher dispatcher = request.getRequestDispatcher("./WEB-INF/jsp/updateUserAns.jsp");
        dispatcher.forward(request, response);
    }
}