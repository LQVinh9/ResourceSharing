package dto;

import java.util.List;

public class Order {

    private int id;
    private User user;
    private List<ItemOrder> itemOrder;
    private int status;

    public Order() {
        this.status = 0;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<ItemOrder> getItemOrder() {
        return itemOrder;
    }

    public void setItemOrder(List<ItemOrder> itemOrder) {
        this.itemOrder = itemOrder;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
