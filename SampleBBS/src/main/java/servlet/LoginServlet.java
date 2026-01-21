package servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.User;
import dao.Dao;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String id = req.getParameter("id");
        String pw = req.getParameter("password");
        User user = new Dao().getUserById(id);

        if (user != null && user.getPassword().equals(pw)) {
            req.getSession().setAttribute("userId", id);
            // 投稿ページへ移動
            req.getRequestDispatcher("./EntryArticlePageServlet").forward(req, resp);
        } else {
            req.getRequestDispatcher("./WEB-INF/jsp/login.jsp").forward(req, resp);
        }
    }
}