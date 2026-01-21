package beans;
import java.io.Serializable;

public class MyData implements Serializable {
    private int id;
    private String data;
    public MyData() {}
    public MyData(int id, String data) { this.id = id; this.data = data; }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getData() { return data; }
    public void setData(String data) { this.data = data; }
}