package beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class Article implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String title;
    private String body;
    private String editorId;
    private int favCount;
    private int dislikeCount;
    private Timestamp entryDatetime;
    private String imageName;      // 画像ファイル名
    private String omikujiResult;  // おみくじ結果

    /**
     * データベースからの取得用コンストラクタ（引数9個）
     */
    public Article(int id, String title, String body, String editorId, int favCount, int dislikeCount, Timestamp entryDatetime, String imageName, String omikujiResult) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.editorId = editorId;
        this.favCount = favCount;
        this.dislikeCount = dislikeCount;
        this.entryDatetime = entryDatetime;
        this.imageName = imageName;
        this.omikujiResult = omikujiResult;
    }

    /**
     * 新規投稿用コンストラクタ（引数5個）
     */
    public Article(String title, String body, String editorId, String imageName, String omikujiResult) {
        this.title = title;
        this.body = body;
        this.editorId = editorId;
        this.imageName = imageName;
        this.omikujiResult = omikujiResult;
    }

    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getBody() { return body; }
    public void setBody(String body) { this.body = body; }

    public String getEditorId() { return editorId; }
    public void setEditorId(String editorId) { this.editorId = editorId; }

    public int getFavCount() { return favCount; }
    public void setFavCount(int favCount) { this.favCount = favCount; }

    public int getDislikeCount() { return dislikeCount; }
    public void setDislikeCount(int dislikeCount) { this.dislikeCount = dislikeCount; }

    public Timestamp getEntryDatetime() { return entryDatetime; }
    public void setEntryDatetime(Timestamp entryDatetime) { this.entryDatetime = entryDatetime; }

    public String getImageName() { return imageName; }
    public void setImageName(String imageName) { this.imageName = imageName; }

    public String getOmikujiResult() { return omikujiResult; }
    public void setOmikujiResult(String omikujiResult) { this.omikujiResult = omikujiResult; }
}