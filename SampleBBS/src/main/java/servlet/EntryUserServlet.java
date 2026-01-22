package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.User;
import dao.Dao;

@WebServlet("/EntryUserServlet")
public class EntryUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String p1 = request.getParameter("password1");
        String p2 = request.getParameter("password2");

        if (p1 == null || !p1.equals(p2)) {
            request.setAttribute("error", "パスワードが一致しません");
            request.getRequestDispatcher("/WEB-INF/jsp/entryUser.jsp").forward(request, response);
            return;
        }

        Dao dao = new Dao();
        if (dao.getUserById(id) != null) {
            request.setAttribute("error", "このIDは既に使用されています");
            request.getRequestDispatcher("/WEB-INF/jsp/entryUser.jsp").forward(request, response);
            return;
        }

        dao.insertUser(new User(id, p1, name));
        response.sendRedirect("./LoginPageServlet");
    }
}