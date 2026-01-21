package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.Article;
import beans.Comment;
import beans.MyData;
import beans.User;

public class Dao extends DriverAccessor {

    // 1. 記事一覧（新着・トレンド・検索対応）
    public List<Article> getArticleList(String keyword, boolean isTrend) {
        Connection connection = this.createConnection();
        List<Article> list = new ArrayList<>();
        try {
            String sql;
            if (keyword != null && !keyword.isBlank()) {
                sql = "SELECT * FROM article WHERE title LIKE ? OR body LIKE ? ORDER BY entry_datetime DESC";
            } else if (isTrend) {
                // 🔥進化：いいね数 ＋ コメント数を score として合算し、その順で並べる
                sql = "SELECT a.*, (a.fav_count + (SELECT COUNT(*) FROM comment c WHERE c.article_id = a.id)) as score FROM article a ORDER BY score DESC, entry_datetime DESC";
            } else {
                sql = "SELECT * FROM article ORDER BY entry_datetime DESC";
            }
            PreparedStatement stmt = connection.prepareStatement(sql);
            if (keyword != null && !keyword.isBlank()) {
                String q = "%" + keyword + "%";
                stmt.setString(1, q); stmt.setString(2, q);
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // image_d63a70.png の 7 カラム構成に完全一致
                list.add(new Article(rs.getInt("id"), rs.getString("title"), rs.getString("body"),
                    rs.getString("editor_id"), rs.getInt("fav_count"), 
                    rs.getInt("dislike_count"), rs.getTimestamp("entry_datetime")));
            }
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
        return list;
    }

    // 2. 記事投稿：EntryArticleServlet のエラーを解消
    public void insertArticle(Article article) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement stmt = connection.prepareStatement("INSERT INTO article (title, body, editor_id) VALUES (?, ?, ?)");
            stmt.setString(1, article.getTitle()); stmt.setString(2, article.getBody()); stmt.setString(3, article.getEditorId());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
    }

    // 3. 記事削除：DeleteServlet のエラーを解消
    public void deleteArticle(int id) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement stmt = connection.prepareStatement("DELETE FROM article WHERE id = ?");
            stmt.setInt(1, id); stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
    }

    // 4. コメント追加：CommentServlet のエラーを解消
    public void insertComment(int articleId, String userId, String body) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement stmt = connection.prepareStatement("INSERT INTO comment (article_id, user_id, body) VALUES (?, ?, ?)");
            stmt.setInt(1, articleId); stmt.setString(2, userId); stmt.setString(3, body);
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
    }

    // 5. コメント削除：DeleteCommentServlet 用
    public void deleteComment(int commentId, String userId) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement stmt = connection.prepareStatement("DELETE FROM comment WHERE id = ? AND user_id = ?");
            stmt.setInt(1, commentId); stmt.setString(2, userId);
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
    }

    // 6. ユーザー取得：LoginServlet 用
    public User getUserById(String id) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM user WHERE id = ?");
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return new User(rs.getString("id"), rs.getString("password"), rs.getString("name"));
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
        return null;
    }

    // 7. いいね・低評価（1人1回制限）：FavoriteServlet, DislikeServlet 用
    public void addFavorite(int articleId, String userId) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement check = connection.prepareStatement("SELECT * FROM favorites WHERE article_id = ? AND user_id = ?");
            check.setInt(1, articleId); check.setString(2, userId);
            if (check.executeQuery().next()) return;
            connection.setAutoCommit(false);
            connection.prepareStatement("UPDATE article SET fav_count = fav_count + 1 WHERE id = " + articleId).executeUpdate();
            PreparedStatement ins = connection.prepareStatement("INSERT INTO favorites (article_id, user_id) VALUES (?, ?)");
            ins.setInt(1, articleId); ins.setString(2, userId); ins.executeUpdate();
            connection.commit();
        } catch (SQLException e) { try { connection.rollback(); } catch (Exception ex) {} } finally { this.closeConnection(connection); }
    }
    public void addDislike(int articleId, String userId) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement check = connection.prepareStatement("SELECT * FROM dislikes WHERE article_id = ? AND user_id = ?");
            check.setInt(1, articleId); check.setString(2, userId);
            if (check.executeQuery().next()) return;
            connection.setAutoCommit(false);
            connection.prepareStatement("UPDATE article SET dislike_count = dislike_count + 1 WHERE id = " + articleId).executeUpdate();
            PreparedStatement ins = connection.prepareStatement("INSERT INTO dislikes (article_id, user_id) VALUES (?, ?)");
            ins.setInt(1, articleId); ins.setString(2, userId); ins.executeUpdate();
            connection.commit();
        } catch (SQLException e) { try { connection.rollback(); } catch (Exception ex) {} } finally { this.closeConnection(connection); }
    }

    // 8. その他、演習用メソッド
    public List<Comment> getCommentsByArticleId(int articleId) {
        Connection connection = this.createConnection();
        List<Comment> list = new ArrayList<>();
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM comment WHERE article_id = ? ORDER BY entry_datetime ASC");
            stmt.setInt(1, articleId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) { list.add(new Comment(rs.getInt("id"), rs.getString("user_id"), rs.getString("body"), rs.getTimestamp("entry_datetime"))); }
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
        return list;
    }
    public void insertUser(User user) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement stmt = connection.prepareStatement("INSERT INTO user (id, password, name) VALUES (?, ?, ?)");
            stmt.setString(1, user.getId()); stmt.setString(2, user.getPassword()); stmt.setString(3, user.getName());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
    }
    public void updateUser(User user) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement stmt = connection.prepareStatement("UPDATE user SET password = ?, name = ? WHERE id = ?");
            stmt.setString(1, user.getPassword()); stmt.setString(2, user.getName()); stmt.setString(3, user.getId());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
    }
    public List<MyData> getMyDataList() {
        Connection connection = this.createConnection();
        List<MyData> list = new ArrayList<>();
        try {
            ResultSet rs = connection.prepareStatement("SELECT * FROM my_data ORDER BY id DESC").executeQuery();
            while (rs.next()) { list.add(new MyData(rs.getInt("id"), rs.getString("data"))); }
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
        return list;
    }
    public void insertMyData(String data) {
        Connection connection = this.createConnection();
        try {
            PreparedStatement stmt = connection.prepareStatement("INSERT INTO my_data (data) VALUES (?)");
            stmt.setString(1, data); stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); } finally { this.closeConnection(connection); }
    }
}