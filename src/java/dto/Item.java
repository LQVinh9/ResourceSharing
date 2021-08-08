package dto;

public class Item {

    private String itemID;
    private String itemName;
    private String color;
    private int quantity;
    private String image;
    private String levelID;
    private String categoryID;

    public Item(String itemID, String itemName, String color, int quantity, String image, String levelID, String categoryID) {
        this.itemID = itemID;
        this.itemName = itemName;
        this.color = color;
        this.quantity = quantity;
        this.image = image;
        this.levelID = levelID;
        this.categoryID = categoryID;
    }

    public String getItemID() {
        return itemID;
    }

    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getLevelID() {
        return levelID;
    }

    public void setLevelID(String levelID) {
        this.levelID = levelID;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }
}
