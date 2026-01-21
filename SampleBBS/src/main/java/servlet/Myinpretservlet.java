package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// --- 必須のインポート ---
import dao.Dao;

@WebServlet("/Myinpretservlet")
public class Myinpretservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String data = request.getParameter("data_text");
        Dao dao = new Dao();
        
        if (data != null && !data.isBlank()) {
            dao.insertMyData(data);
        }
        // 登録後は記事一覧へリダイレクト
        response.sendRedirect("./ArticleListServlet");
    }
}