package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao; // インポート必須

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        int articleId = Integer.parseInt(request.getParameter("articleId"));
        String body = request.getParameter("commentBody");
        String userId = (String) request.getSession().getAttribute("userId");

        if (body != null && !body.isBlank() && userId != null) {
            // 決定版のDaoメソッドを呼び出し
            new Dao().insertComment(articleId, userId, body);
        }
        response.sendRedirect("./ArticleListServlet");
    }
}