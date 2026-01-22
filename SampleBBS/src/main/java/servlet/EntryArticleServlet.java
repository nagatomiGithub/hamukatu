package servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import beans.Article;
import dao.Dao;

@WebServlet("/EntryArticleServlet")
// 📸 画像受取に必須の設定（5MB制限など）
@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=10*1024*1024)
public class EntryArticleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String title = request.getParameter("title");
        String body = request.getParameter("body");
        String editorId = (String) request.getSession().getAttribute("userId");
        
        // 📸 画像ファイルの取得
        Part filePart = request.getPart("imageFile");
        String imageName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            imageName = filePart.getSubmittedFileName();
            // サーバー上の保存先（webapp/uploads）のパスを取得
            String path = getServletContext().getRealPath("/uploads");
            
            // フォルダがなければ作成
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            // ファイルを物理保存
            filePart.write(path + File.separator + imageName);
        }

        // 入力チェックとDB保存
        if (editorId != null && title != null && !title.isEmpty() && body != null && !body.isEmpty()) {
            // 新しいArticleコンストラクタ（引数4個）を使用
            Article article = new Article(title, body, editorId, imageName);
            new Dao().insertArticle(article);
        }
        
        // 投稿後はフィードへ
        response.sendRedirect("./ArticleListServlet");
    }
}