package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Article;
import dao.Dao; // インポート必須

@WebServlet("/EntryArticleServlet")
public class EntryArticleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String title = request.getParameter("title");
        String body = request.getParameter("body");
        String editorId = (String) request.getSession().getAttribute("userId");

        if (editorId != null && title != null && body != null) {
            Article articleToEntry = new Article(title, body, editorId);
            // 決定版のDaoメソッドを呼び出し
            new Dao().insertArticle(articleToEntry);
        }
        
        response.sendRedirect("./ArticleListServlet");
    }
}