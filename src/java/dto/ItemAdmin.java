package dto;

public class ItemAdmin {

    private String bookingDetailID;
    private String itemID;
    private String itemName;
    private String color;
    private String image;
    private int quantity;
    private String dateBorrow;
    private String statusRequest;
    private String date;
    private String userID;
    private String userName;
    private String roleName;

    public ItemAdmin(String bookingDetailID, String itemID, String itemName, String color, String image, int quantity, String dateBorrow, String statusRequest, String date, String userID, String userName, String roleName) {
        this.bookingDetailID = bookingDetailID;
        this.itemID = itemID;
        this.itemName = itemName;
        this.color = color;
        this.image = image;
        this.quantity = quantity;
        this.dateBorrow = dateBorrow;
        this.statusRequest = statusRequest;
        this.date = date;
        this.userID = userID;
        this.userName = userName;
        this.roleName = roleName;
    }

    public String getBookingDetailID() {
        return bookingDetailID;
    }

    public void setBookingDetailID(String bookingDetailID) {
        this.bookingDetailID = bookingDetailID;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDateBorrow() {
        return dateBorrow;
    }

    public void setDateBorrow(String dateBorrow) {
        this.dateBorrow = dateBorrow;
    }

    public String getStatusRequest() {
        return statusRequest;
    }

    public void setStatusRequest(String statusRequest) {
        this.statusRequest = statusRequest;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
