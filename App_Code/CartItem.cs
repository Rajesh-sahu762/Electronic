public class CartItem
{
    public int ProductID { get; set; }
    public string ProductName { get; set; }
    public string ImagePath { get; set; } // 🔥 REQUIRED
    public decimal Price { get; set; }
    public int Quantity { get; set; }
}
