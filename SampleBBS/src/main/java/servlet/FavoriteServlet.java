package servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao; // インポート追加

@WebServlet("/FavoriteServlet")
public class FavoriteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = (String) req.getSession().getAttribute("userId");
        String idStr = req.getParameter("id");
        if (userId != null && idStr != null) {
            new Dao().addFavorite(Integer.parseInt(idStr), userId);
        }
        resp.sendRedirect("./ArticleListServlet");
    }
}