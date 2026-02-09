<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="Client_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

 
    <style>

    .category-grid{
    display:grid;
    margin-left:20px;
    grid-template-columns: repeat(3, 1fr); /* 👈 3 in one row */
   
}

        .button{
            margin: 5px 5px 5px 5px;
             width: 130px;
  height: 40px;
  color: #fff;
  border-radius: 5px;
  border:none;
  padding: 10px 25px;
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background: #ffb300;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  display: inline-block;
  
        }
        .quick-buy {
        }

.category-card{
    background:#fff;
    border-radius:12px;
    padding:15px;
    border-right-width: 0.8px;
    border-top-width: 0.8px;
    border-bottom-width: 0.8px;
    box-shadow:0 6px 20px rgba(0,0,0,0.08);
}

.category-card img{
    width:100%;
    height:180px;
    object-fit:cover;
    border-radius:10px;
}

@media(max-width:991px){
    .category-grid{
        grid-template-columns: repeat(2, 1fr);
    }
}
@media(max-width:575px){
    .category-grid{
        grid-template-columns: 1fr;
    }
}

        .bwp-woo-categories.list-category2 {
            padding: 25px;
        
        }


        /* FIX SLIDER IMAGE ALIGNMENT */
        rs-module rs-slide img {
            object-fit: contain !important;
            object-position: center center !important;
        }

        rs-module-wrap {
            overflow: hidden !important;
        }

        rs-slide {
            display: flex !important;
            align-items: center !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="bwp-main" class="bwp-main">
        <div class="breadcrumb-noheading">
            <div class="container">
                <div class="breadcrumb" itemprop="breadcrumb"><a href="../../index.html">Home</a><span class="delimiter"></span><a href="../index.html">Shop</a><span class="delimiter"></span><a href="../../product-category/computers/index.html">Computers</a><span class="delimiter"></span>Air Cooler With A-RGB</div>
            </div>
        </div>
        <div id="primary" class="content-area">
            <main id="main" class="site-main" role="main"><div class="clearfix">
	<div class="contents-detail">
		<div class="main-single-product">	
			<div class="col-xl-12 col-lg-12 col-md-12 col-12">
									<div class="woocommerce-notices-wrapper"></div><div id="product-3989" class="post-3989 product type-product status-publish has-post-thumbnail product_brand-hopin product_cat-computers product_tag-hot product_tag-trend first instock featured shipping-taxable purchasable product-type-simple">
		<div class="bwp-single-product product scroll zoom"
		data-product_layout_thumb 		= 	"scroll"
				data-zoom_scroll 				=	"true" 
		data-zoom_contain_lens 			=	"true" 
		data-zoomtype 					=	"inner" 
		data-lenssize 					= 	"200" 
		data-lensshape 					= 	"square" 
		data-lensborder 				= 	""
		data-bordersize					= 	"2"
		data-bordercolour 				= 	"#f9b61e"
				data-popup 						= 	"false">	
		<div class="row">
							<div class="bwp-single-image col-lg-7 col-md-12 col-12">
					<div class="images vertical">
	<figure class="woocommerce-product-gallery woocommerce-product-gallery--with-images images">
		<div class="row">
							<div class="col-md-2">
						<div class="content-thumbnail-scroll max-thumbnail">
		<div class="image-thumbnail slick-carousel" data-asnavfor=".image-additional" data-focusonselect="true" data-columns4="4" data-columns3="4" data-columns2="4" data-columns1="4" data-columns="4" data-nav="true" data-vertical=&quot;true&quot; data-verticalswiping=&quot;true&quot;>
						<asp:Repeater ID="rptThumbs" runat="server">
<ItemTemplate>
    <div class="img-thumbnail">
        <span class="img-thumbnail-scroll">
            <img src="../Uploads/ProductImages/<%# Eval("ImagePath") %>" />
        </span>
    </div>
</ItemTemplate>
</asp:Repeater>
<asp:Repeater ID="rptMainImages" runat="server">
<ItemTemplate>
    <div class="img-thumbnail woocommerce-product-gallery__image">
        <a href="../Uploads/ProductImages/<%# Eval("ImagePath") %>">
            <img class="attachment-shop_single"
                 src="../Uploads/ProductImages/<%# Eval("ImagePath") %>" />
        </a>
    </div>
</ItemTemplate>
</asp:Repeater>

						</div>
	</div>
					</div>
						<div class="col-md-10">
		<div class="scroll-image">
    <div class="image-additional slick-carousel"
         data-asnavfor=".image-thumbnail"
         data-fade="true"
         data-columns="1"
         data-nav="true">

        <asp:Repeater ID="rptMainImagesBig" runat="server">
            <ItemTemplate>
                <div class="img-thumbnail woocommerce-product-gallery__image"
                     data-thumb="../Uploads/ProductImages/<%# Eval("ImagePath") %>">

                    <a data-elementor-open-lightbox="default"
                       data-elementor-lightbox-slideshow="image-additional"
                       href="../Uploads/ProductImages/<%# Eval("ImagePath") %>">

                        <img class="attachment-shop_single size-shop_single wp-post-image"
                             src="../Uploads/ProductImages/<%# Eval("ImagePath") %>"
                             alt="Product Image" />
                    </a>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</div>


			</div>
				
		</div>
	</figure>
</div>				</div>
				<div class="bwp-single-info col-lg-5 col-md-12 col-12 ">
										<div class="summary entry-summary">
					<asp:FormView ID="fvProduct" runat="server">
<ItemTemplate>

<h1 itemprop="name" class="product_title entry-title">
    <%# Eval("ProductName") %>
</h1>

<div class="price-single">
    <div class="price">
        ₹<%# Eval("Price") %>
    </div>
</div>

<div itemprop="description" class="description">
    <%# Eval("Description") %>
</div>

<p class="stock in-stock">
    <%# Eval("Stock") %> in stock
</p>

</ItemTemplate>
</asp:FormView>
		<div class="cart">
		<div class="quantity-button">
						<div class="quantity">
	<button type="button" class="plus"><i class="feather-plus"></i></button>	<label class="screen-reader-text" for="quantity_6980529657181">Air Cooler With A-RGB quantity</label>
	<input
		type="number"
				id="quantity_6980529657181"
		class="input-text qty text"
		name="quantity"
		value="1"
		aria-label="Product quantity"
				min="1"
		max="36"
					step="1"
			placeholder=""
			inputmode="numeric"
			autocomplete="off"
			/>
	<button type="button" class="minus"><i class="feather-minus"></i></button></div>
			<input type="hidden" name="add-to-cart" value="3989" />
		</div>
            <asp:Button 
    ID="btnAddToCart"
    runat="server"
    CssClass="button alt"
    Text="Add to Cart"
    OnClick="btnAddToCart_Click" />

            <asp:Button 
    ID="btnBuyNow"
    runat="server"
    CssClass="button alt"
    Text="Buy Now"
    OnClick="btnBuyNow_Click" />


		</div>
			<div class="safe-checkout">
			<div class="img-safe-checkout">
				<img src="../../wp-content/uploads/2023/05/payments-2.png" alt="Image Safe Checkout">
			</div>
			<div class="title-safe-checkout">Guaranteed Safe Checkout</div>
		</div>
				<ul class="product-shipping-delivers">
					<li class="product-shipping">
				<i class="wpb-icon-shipping"></i>Free worldwide shipping on all orders over $100			</li>
							<li class="product-delivers">
				<i class="wpb-icon-delivers"></i>Delivers in: 3-7 Working Days									<a href="../../refund_returns/index.html">Shipping &amp; Return</a>
							</li>
			</ul>
	<div class="product_meta">

	
	
		<span class="sku_wrapper">SKU: <span class="sku">VN00189</span></span>

	
	<span class="posted_in">Category: <a href="../../product-category/computers/index.html" rel="tag">Computers</a></span>
	<span class="tagged_as">Tags: <a href="../../product-tag/hot/index.html" rel="tag">Hot</a>, <a href="../../product-tag/trend/index.html" rel="tag">Trend</a></span>
	 <span class="posted_in">Brand: <a href="../../brand/hopin/index.html" rel="tag">Hopin</a></span>
</div>
<div class="social-icon"><label>Share : </label><div class="social-share"><a href="https://www.facebook.com/share_channel/?type=reshare&amp;link=https%3A%2F%2Farostore.wpbingosite.com%2Fshop%2Fair-cooler-with-a-rgb%2F&amp;app_id=966242223397117&amp;source_surface=external_reshare&amp;display&amp;hashtag" title="Facebook" class="share-facebook" target="_blank"><i class="fa fa-facebook"></i></a><a href="https://twitter.com/intent/tweet?url=https://arostore.wpbingosite.com/shop/air-cooler-with-a-rgb/"  title="Twitter" class="share-twitter"><i class="icon-x-twitter"></i></a><a href="https://www.linkedin.com/shareArticle?mini=true&amp;url=https://arostore.wpbingosite.com/shop/air-cooler-with-a-rgb/"  title="LinkedIn" class="share-linkedin"><i class="fa fa-linkedin"></i></a></div></div>					</div><!-- .summary -->
				</div>
					</div>
	</div>
			<div class="woocommerce-tabs wc-tabs-wrapper description-style-tab">
					<div class="content-woocommerce-tabs">
				<div class="content-ul-tab">
					<ul class="tabs wc-tabs" role="tablist">
													<li class="description_tab" id="tab-title-description" role="tab" aria-controls="tab-description">
								<a href="#tab-description">
									Description								</a>
							</li>
													<li class="reviews_tab" id="tab-title-reviews" role="tab" aria-controls="tab-reviews">
								<a href="#tab-reviews">
									Reviews (1)								</a>
							</li>
											</ul>
				</div>
				<div class="content-tab">
											<div class="container-tab">
							<div class="tab-title hidden-lg hidden-md" data-id="tab-description">
								Description							</div>
							<div class="woocommerce-Tabs-panel woocommerce-Tabs-panel--description panel entry-content wc-tab" id="tab-description" role="tabpanel" aria-labelledby="tab-title-description">
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
							</div>
						</div>
											<div class="container-tab">
							<div class="tab-title hidden-lg hidden-md" data-id="tab-reviews">
								Reviews (1)							</div>
							<div class="woocommerce-Tabs-panel woocommerce-Tabs-panel--reviews panel entry-content wc-tab" id="tab-reviews" role="tabpanel" aria-labelledby="tab-title-reviews">
								<div id="reviews" class="woocommerce-Reviews">
	<div id="comments">
		<h2 class="woocommerce-Reviews-title">1 review for <span>Air Cooler With A-RGB</span></h2>
					<ol class="commentlist">
				<li class="review byuser comment-author-demodemo-com even thread-even depth-1" id="li-comment-66">
	<div class="content_comment_container">
		<div id="comment-66" class="comment_container">

			<img alt='' src='https://secure.gravatar.com/avatar/9956d6a8168de87560ad6918838818f2c3a1995f2575285da6609a748322863c?s=60&amp;d=mm&amp;r=g' srcset='https://secure.gravatar.com/avatar/9956d6a8168de87560ad6918838818f2c3a1995f2575285da6609a748322863c?s=120&#038;d=mm&#038;r=g 2x' class='avatar avatar-60 photo' height='60' width='60' decoding='async'/>
			<div class="comment-text">

				<div class="star-rating" role="img" aria-label="Rated 5 out of 5"><span style="width:100%">Rated <strong class="rating">5</strong> out of 5</span></div>
	<p class="meta">
		<strong class="woocommerce-review__author">Wpbingo </strong>
				<span class="woocommerce-review__dash">&ndash;</span> <time class="woocommerce-review__published-date" datetime="2018-10-04T03:17:11+00:00">October 4, 2018</time>
	</p>

	
			</div>
		</div>
		<div class="description"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fringilla augue nec est tristique auctor. Donec non est at libero vulputate rutrum. Morbi ornare lectus quis justo gravida semper. Nulla tellus mi, vulputate adipiscing cursus eu, suscipit id nulla.</p>
</div>	</div>
</li><!-- #comment-## -->
			</ol>
						</div>
			<p class="woocommerce-verification-required">Only logged in customers who have purchased this product may leave a review.</p>
		<div class="clear"></div>
</div>							</div>
						</div>
									</div>
			</div>
			</div>
			<div class="related bwp_slick-margin-mobile">
			<div class="title-block"><h2>Related Products</h2></div>
			<div class="content-product-list">
				<div class="products-list grid slick-carousel" data-nav="true" data-columns4="1" data-columns3="2" data-columns2="2" data-columns1="3" data-columns="4">
									<asp:Repeater ID="rptRelated" runat="server">
<ItemTemplate>

<div class="products-entry content-product1 clearfix product-wapper">

    <div class="products-thumb">

                <div class="product-lable">
                         </div>

                <div class="product-thumb-hover">
                    <a href='ProductDetails.aspx?pid=<%# Eval("ProductID") %>'>
                        <img src='../Uploads/ProductImages/<%# Eval("MainImage") %>' class="wp-post-image" />
                        <img src='../Uploads/ProductImages/<%# Eval("HoverImage") %>' class="hover-image back" />
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
            <h3 class="product-title"><%# Eval("ProductName") %></h3>
            <span class="price">₹<%# Eval("Price") %></span>
        </div>
    </div>

</div>

</ItemTemplate>
</asp:Repeater>

									</div>
			</div>	
		</div>
		<meta itemprop="url" content="index.html" />
</div><!-- #product-3989 -->
							</div>
			</main>
        </div>
    </div>

</asp:Content>

