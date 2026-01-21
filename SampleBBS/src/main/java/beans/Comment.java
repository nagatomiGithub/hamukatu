package beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class Comment implements Serializable {

    private int id;
    private String userId;
    private String body;
    private Timestamp entryDatetime;

    public Comment(int id, String userId, String body, Timestamp entryDatetime) {
        this.id = id;
        this.userId = userId;
        this.body = body;
        this.entryDatetime = entryDatetime;
    }

    public int getId() { return id; }
    public String getUserId() { return userId; }
    public String getBody() { return body; }
    public Timestamp getEntryDatetime() { return entryDatetime; }
}
