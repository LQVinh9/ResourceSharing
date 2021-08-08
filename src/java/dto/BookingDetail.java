package dto;

public class BookingDetail {

    private String bookingDetailID;
    private int quantity;
    private String dateBorrow;
    private String statusRequest;
    private String status;
    private String itemID;
    private String bookingID;

    public BookingDetail(String bookingDetailID, int quantity, String dateBorrow, String statusRequest, String status, String itemID, String bookingID) {
        this.bookingDetailID = bookingDetailID;
        this.quantity = quantity;
        this.dateBorrow = dateBorrow;
        this.statusRequest = statusRequest;
        this.status = status;
        this.itemID = itemID;
        this.bookingID = bookingID;
    }

    public String getBookingDetailID() {
        return bookingDetailID;
    }

    public void setBookingDetailID(String bookingDetailID) {
        this.bookingDetailID = bookingDetailID;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getItemID() {
        return itemID;
    }

    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }
}
