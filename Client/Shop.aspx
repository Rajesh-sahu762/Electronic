<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Shop.aspx.cs" Inherits="Client_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>


/* SORT DROPDOWN */
.woocommerce-ordering .pwb-dropdown-toggle {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 14px;
    border: 1px solid #ddd;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    background: #fff;
}

/* GRID BUTTONS */
.view-grid {
    width: 42px;
    height: 42px;
    border: 1px solid #ddd;
    border-radius: 6px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    margin-left: 6px;
}

.view-grid svg rect {
    fill: #ccc;
}

.view-grid.active {
    border-color: #ffb400;
}

.view-grid.active svg rect {
    fill: #ffb400;
}

/* HOVER */
.view-grid:hover {
    border-color: #999;
}


    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div id="bwp-main" class="bwp-main">
        <div data-bg_default="https://arostore.wpbingosite.com/wp-content/uploads/2023/07/bg-breadcrumb.jpg" class="page-title page-title-default bwp-title" style="background-image: url(../wp-content/uploads/2023/07/bg-breadcrumb.jpg);">
            <div class="container">
                <div class="content-title-heading">
                    <span class="back-to-shop">Shop</span>
                    <h1 class="text-title-heading">Shop		</h1>
                </div>
                <!-- Page Title -->
                <div class="breadcrumb"><a href="Index.aspx">Home</a><span class="delimiter"></span>Shop</div>
            </div>
        </div>
        <!-- .container -->
        <div id="primary" class="content-area">
            <main id="main" class="site-main" role="main"><div class="filter_sideout  shop-layout-full">
	<div class="remove-sidebar"></div>
					<div class="container">
			<div class="main-archive-product row">
								<div class="col-xl-12 col-lg-12 col-md-12 col-12" >
																<div class="bwp-top-bar top clearfix">				
							<div class="woocommerce-notices-wrapper"></div>
     <div class="woocommerce-ordering pwb-dropdown dropdown">
   <span class="pwb-dropdown-toggle dropdown-toggle" data-toggle="dropdown" role="button">
    <%= 
        Request.QueryString["orderby"] == null ? "Default Sorting" :
        Request.QueryString["orderby"] == "date" ? "Sort by latest" :
        Request.QueryString["orderby"] == "price" ? "Price: low to high" :
        Request.QueryString["orderby"] == "price-desc" ? "Price: high to low" :
        "Default Sorting"
    %>
</span>


    <ul class="pwb-dropdown-menu dropdown-menu">
        <li><a href="Shop.aspx">Default sorting</a></li>
        <li><a href="Shop.aspx?orderby=date">Sort by latest</a></li>
        <li><a href="Shop.aspx?orderby=price">Price: low to high</a></li>
        <li><a href="Shop.aspx?orderby=price-desc">Price: high to low</a></li>
    </ul>
</div>

         <div class="display hidden-sm hidden-xs">

    <a class="view-grid two" data-col="col-lg-6 col-md-6 col-sm-6 col-6">
        <svg width="6" height="16" viewBox="0 0 6 16">
            <rect width="2" height="16" rx="1"></rect>
            <rect x="4" width="2" height="16" rx="1"></rect>
        </svg>
    </a>

    <a class="view-grid three" data-col="col-lg-4 col-md-4 col-sm-6 col-6">
        <svg width="10" height="16" viewBox="0 0 10 16">
            <rect width="2" height="16" rx="1"></rect>
            <rect x="4" width="2" height="16" rx="1"></rect>
            <rect x="8" width="2" height="16" rx="1"></rect>
        </svg>
    </a>

    <a class="view-grid four active" data-col="col-lg-3 col-md-4 col-sm-6 col-6">
        <svg width="14" height="16" viewBox="0 0 14 16">
            <rect width="2" height="16" rx="1"></rect>
            <rect x="4" width="2" height="16" rx="1"></rect>
            <rect x="8" width="2" height="16" rx="1"></rect>
            <rect x="12" width="2" height="16" rx="1"></rect>
        </svg>
    </a>

</div>

			<div class="woocommerce-filter-title">
																				</div>
									
						</div>
													
												<div class="content-products-list">
							<ul class="products products-list row grid" data-col="col-lg-3 col-md-4 col-sm-6 col-6">								
                                								
<asp:Repeater ID="rptShopProducts" runat="server">
<ItemTemplate>

<li class="col-lg-3 col-md-4 col-sm-6 col-6">
<div class="products-entry content-product1 clearfix product-wapper">

<div class="products-thumb">

    <div class="product-thumb-hover">
        <a href="ProductDetails.aspx?pid=<%# Eval("ProductID") %>"
           class="woocommerce-LoopProduct-link">

            <!-- MAIN IMAGE -->
            <img 
                class="wp-post-image"
                src="../Uploads/ProductImages/<%# Eval("MainImage") %>" 
                alt="<%# Eval("ProductName") %>" />

            <!-- HOVER IMAGE -->
            <img 
                class="hover-image back"
                src="../Uploads/ProductImages/<%# Eval("HoverImage") %>" 
                alt="<%# Eval("ProductName") %>" />

        </a>
    </div>
    <div class="product-actions">

    <!-- ❤️ Wishlist -->
    <button type="button"
            class="my-wishlist-btn"
            data-pid="<%# Eval("ProductID") %>"
            onclick="toggleWishlist(this)">
        ♥
    </button>

    <!-- 👁 Quickview -->
    <button type="button"
            class="quickview-btn"
            onclick="openQuickView(<%# Eval("ProductID") %>)">
        🔍
    </button>

</div>


</div>


<div class="products-content">
<div class="contents">

<h3 class="product-title">
    <%# Eval("ProductName") %>
</h3>

<span class="price">
    ₹<%# Eval("Price") %>
</span>

</div>
</div>

</div>
</li>

</ItemTemplate>
</asp:Repeater>

															</ul>						</div>
						<div class="bwp-top-bar bottom clearfix">
							<nav class="woocommerce-pagination shop-loadmore">
	<div class="woocommerce-product-count">	
		Showing 1&ndash;12 of 26 item(s)	</div>
	<div class="percent-content"><div class="percent" style="width:46.153846153846%;"></div></div>
	<div class="loadmore">
		<button type="button" class="woocommerce-load-more" data-paged="1">
			<strong class="lds-ellipsis"><strong></strong><strong></strong><strong></strong><strong></strong></strong>
			<span class="loadmore-button-text">Load More</span>
		</button>
	</div>
</nav>
						</div>
									</div>
			</div>
		</div>	
	</div>
</main>
        </div>
    </div>
    <!-- #main -->



    <script>
        document.querySelectorAll(".view-grid").forEach(btn => {
            btn.addEventListener("click", function (e) {
                e.preventDefault();

                let colClass = this.getAttribute("data-col");
                let items = document.querySelectorAll(".products-list > li");

                items.forEach(li => {
                    li.className = colClass;
            });

        document.querySelectorAll(".view-grid").forEach(b => b.classList.remove("active"));
        this.classList.add("active");
        });
        });
</script>


</asp:Content>

