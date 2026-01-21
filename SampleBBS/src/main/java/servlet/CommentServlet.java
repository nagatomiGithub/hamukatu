package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String articleIdStr = request.getParameter("articleId");
        String body = request.getParameter("commentBody");
        String userId = (String) request.getSession().getAttribute("userId");

        if (articleIdStr != null && body != null && !body.isBlank() && userId != null) {
            try {
                int articleId = Integer.parseInt(articleIdStr);
                new Dao().insertComment(articleId, userId, body);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // 記事一覧へ戻る
        response.sendRedirect(request.getContextPath() + "/ArticleListServlet");
    }
}
