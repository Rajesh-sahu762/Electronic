public class CartItem
{
    public int ProductID { get; set; }
    public int VendorID { get; set; }   // 🔥 REQUIRED
    public string ProductName { get; set; }
    public string ImagePath { get; set; }
    public decimal Price { get; set; }
    public int Quantity { get; set; }
}
