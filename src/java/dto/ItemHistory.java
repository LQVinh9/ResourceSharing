package dto;

public class ItemHistory {

    private String bookingDetailID;
    private String itemName;
    private String color;
    private String image;
    private int quantity;
    private String dateBorrow;
    private String statusRequest;
    private String date;

    public ItemHistory(String bookingDetailID, String itemName, String color, String image, int quantity, String dateBorrow, String statusRequest, String date) {
        this.bookingDetailID = bookingDetailID;
        this.itemName = itemName;
        this.color = color;
        this.image = image;
        this.quantity = quantity;
        this.dateBorrow = dateBorrow;
        this.statusRequest = statusRequest;
        this.date = date;
    }

    public String getBookingDetailID() {
        return bookingDetailID;
    }

    public void setBookingDetailID(String bookingDetailID) {
        this.bookingDetailID = bookingDetailID;
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
}
