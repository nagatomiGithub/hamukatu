package beans;
import java.io.Serializable;
import java.sql.Timestamp;

public class Article implements Serializable {
    private int id;
    private String title;
    private String body;
    private String editorId;
    private int favCount;
    private Timestamp entryDatetime;

    public Article() {}

    // 新規投稿用（EntryArticleServletで使用）
    public Article(String title, String body, String editorId) {
        this.title = title;
        this.body = body;
        this.editorId = editorId;
    }

    // 全データ取得用（Daoで使用）
    public Article(int id, String title, String body, String editorId, int favCount, Timestamp entryDatetime) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.editorId = editorId;
        this.favCount = favCount;
        this.entryDatetime = entryDatetime;
    }

    // 全てのGetter/Setter
    public int getId() { return id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getBody() { return body; }
    public void setBody(String body) { this.body = body; }
    public String getEditorId() { return editorId; }
    public void setEditorId(String editorId) { this.editorId = editorId; }
    public int getFavCount() { return favCount; }
    public void setFavCount(int favCount) { this.favCount = favCount; }
    public Timestamp getEntryDatetime() { return entryDatetime; }
    public void setEntryDatetime(Timestamp entryDatetime) { this.entryDatetime = entryDatetime; }
}