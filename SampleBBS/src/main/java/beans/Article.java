package beans;
import java.io.Serializable;
import java.sql.Timestamp;

public class Article implements Serializable {
    private int id;
    private String title;
    private String body;
    private String editorId;
    private int favCount;
    private int dislikeCount;
    private Timestamp entryDatetime;
    private String imageName; // 新規追加

    // 取得用（全フィールド）
    public Article(int id, String title, String body, String editorId, int favCount, int dislikeCount, Timestamp entryDatetime, String imageName) {
        this.id = id; this.title = title; this.body = body; this.editorId = editorId;
        this.favCount = favCount; this.dislikeCount = dislikeCount;
        this.entryDatetime = entryDatetime; this.imageName = imageName;
    }

    // 投稿用（4フィールド）
    public Article(String title, String body, String editorId, String imageName) {
        this.title = title; this.body = body; this.editorId = editorId; this.imageName = imageName;
    }

    // Getter & Setter
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getBody() { return body; }
    public String getEditorId() { return editorId; }
    public int getFavCount() { return favCount; }
    public int getDislikeCount() { return dislikeCount; }
    public Timestamp getEntryDatetime() { return entryDatetime; }
    public String getImageName() { return imageName; }
}