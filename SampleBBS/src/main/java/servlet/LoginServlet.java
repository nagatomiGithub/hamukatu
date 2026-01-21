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

    // GETで来た場合はログイン画面へ戻す
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("=== LoginServlet doGet called ===");
        resp.sendRedirect(req.getContextPath() + "/LoginPageServlet");
    }

    // ログイン処理本体
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("=== LoginServlet doPost called ===");

        req.setCharacterEncoding("UTF-8");
        String id = req.getParameter("id");
        String pw = req.getParameter("password");

        System.out.println("id=" + id);
        System.out.println("pw=" + pw);

        User user = new Dao().getUserById(id);

        if (user != null && user.getPassword().equals(pw)) {
            // ログイン成功
            req.getSession().setAttribute("userId", id);
            resp.sendRedirect(req.getContextPath() + "/ArticleListServlet");
        } else {
            // ログイン失敗
            resp.sendRedirect(req.getContextPath() + "/LoginPageServlet");
        }
    }
}
