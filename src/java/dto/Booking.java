package dto;

public class Booking {

    private String bookingID;
    private String date;
    private String userID;

    public Booking(String bookingID, String date, String userID) {
        this.bookingID = bookingID;
        this.date = date;
        this.userID = userID;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
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
}
