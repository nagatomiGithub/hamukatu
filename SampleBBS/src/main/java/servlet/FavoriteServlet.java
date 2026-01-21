package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;

@WebServlet("/FavoriteServlet")
public class FavoriteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ログイン中ユーザー取得
        String userId = (String) req.getSession().getAttribute("userId");
        String idStr = req.getParameter("id");

        if (userId != null && idStr != null) {
            try {
                int articleId = Integer.parseInt(idStr);
                new Dao().addFavorite(articleId, userId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // 記事一覧へ戻る（contextPath付き）
        resp.sendRedirect(req.getContextPath() + "/ArticleListServlet");
    }
}
