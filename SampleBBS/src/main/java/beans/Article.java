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

    public Article() {}

    // ★ 新規投稿用（必須・安全）
    public Article(String title, String body, String editorId) {
        this.title = title;
        this.body = body;
        this.editorId = editorId;
        this.favCount = 0;
        this.dislikeCount = 0;
        this.entryDatetime = null;
    }

    // ★ 一覧表示用（SELECT用）
    public Article(int id, String title, String body,
                   String editorId, int favCount,
                   int dislikeCount, Timestamp entryDatetime) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.editorId = editorId;
        this.favCount = favCount;
        this.dislikeCount = dislikeCount;
        this.entryDatetime = entryDatetime;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getBody() { return body; }
    public String getEditorId() { return editorId; }
    public int getFavCount() { return favCount; }
    public int getDislikeCount() { return dislikeCount; }
    public Timestamp getEntryDatetime() { return entryDatetime; }
}
