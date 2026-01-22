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
@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=10*1024*1024)
public class EntryArticleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // JSPからの入力値を取得
        String title = request.getParameter("title");
        String body = request.getParameter("body");
        String omikuji = request.getParameter("omikujiResult"); // 🌟hiddenからおみくじ結果を取得
        String editorId = (String) request.getSession().getAttribute("userId");
        
        // 画像ファイルの取得と保存処理
        Part filePart = request.getPart("imageFile");
        String imageName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            imageName = filePart.getSubmittedFileName();
            // サーバー内の保存先パス（webapp/uploads）を取得
            String path = getServletContext().getRealPath("/uploads");
            
            // フォルダが存在しない場合は作成
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            // ファイルを物理的に書き出し
            filePart.write(path + File.separator + imageName);
        }

        // 入力値が揃っていればDBに保存
        if (editorId != null && title != null && !title.isEmpty() && body != null && !body.isEmpty()) {
            // Article.java の新しいコンストラクタ（引数5個）を使用
            // (タイトル, 本文, 投稿者ID, 画像名, おみくじ結果)
            Article article = new Article(title, body, editorId, imageName, omikuji);
            
            Dao dao = new Dao();
            dao.insertArticle(article);
        }
        
        // 投稿完了後は一覧画面へ戻る
        response.sendRedirect("./ArticleListServlet");
    }
}