<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Client_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">



    <style>



/* overlay wrapper */
.product-actions {
    position: absolute;
    top: 12px;
    right: 12px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    opacity: 0;
    transform: translateY(-6px);
    transition: all .25s ease;
    z-index: 25;
}

.products-entry:hover .product-actions {
    opacity: 1;
    transform: translateY(0); /* 🔥 pehle jaisa smooth */
}


/* QUICKVIEW ICON BUTTON */
.quickview-btn {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: #fff;
    border: none;
    cursor: pointer;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 16px;
    color: #333;
    box-shadow: 0 4px 12px rgba(0,0,0,.15);
    transition: all .25s ease;
}

.quickview-btn:hover {
    background: #000;
    color: #fff;
}

/* 🔥 kill Arostore default quickview text */
.product-quickview,
.product-quickview * {
    display: none !important;
}

/* 🔒 make sure parent is reference */
.products-thumb,
.product-thumb-hover {
    position: relative !important;
}

/* ❤️ wishlist button – universal fix */
.wishlist-btn {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: #fff;
    border: none;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 18px;
    cursor: pointer;

    box-shadow: 0 4px 12px rgba(0,0,0,.15);
    transition: all .25s ease;
    color: #888;
}

.wishlist-btn:hover {
    transform: scale(1.08);
}

.wishlist-btn.active {
    background: #ff6a00;
    color: #fff;
}



    .category-grid{
    display:grid;
    margin-left:20px;
    grid-template-columns: repeat(3, 1fr); /* 👈 3 in one row */
   
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div id="bwp-main" class="bwp-main">

        <div id="main-content" class="main-content">
            <div id="primary" class="content-area container">
                <div id="content" class="site-content" role="main">
                    <article id="post-11550" class="post-11550 page type-page status-publish hentry">
                        <div class="entry-content clearfix">
                            <div data-elementor-type="wp-page" data-elementor-id="11550" class="elementor elementor-11550">
                                <section class="elementor-section elementor-top-section elementor-element elementor-element-77b5d93 m-t-0 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="77b5d93" data-element_type="section">
                                    <div class="elementor-container elementor-column-gap-default">
                                        <div class="elementor-column elementor-col-100 elementor-top-column elementor-element elementor-element-9910d19" data-id="9910d19" data-element_type="column">
                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                <div class="elementor-element elementor-element-3299515 elementor-widget elementor-widget-slider_revolution" data-id="3299515" data-element_type="widget" data-widget_type="slider_revolution.default">
                                                    <div class="elementor-widget-container">

                                                        <div class="wp-block-themepunch-revslider">
                                                            <!-- START Slider 4 REVOLUTION SLIDER 6.7.5 -->
                                                            <p class="rs-p-wp-fix"></p>
                                                            <rs-module-wrap id="rev_slider_150_1_wrapper" data-source="gallery" style="visibility: hidden; background: transparent; padding: 0; margin: 0px auto; margin-top: 0; margin-bottom: 0;">
				<rs-module id="rev_slider_150_1" class="border-slider" style="" data-version="6.7.5">
					<rs-slides style="overflow: hidden; position: absolute;">
						<rs-slide style="position: absolute;" data-key="rs-676" data-title="Slide" data-thumb="//arostore.wpbingosite.com/wp-content/uploads/2022/12/slider-9.jpg" data-in="o:1;" data-out="y:-100%;" data-alttrans="boxfade,boxslide" data-p1="01">
							<img decoding="async" src="../wp-content/plugins/revslider/sr6/assets/assets/dummy.png" alt="Slide" class="rev-slidebg tp-rs-img rs-lazyload" data-lazyload="//arostore.wpbingosite.com/wp-content/plugins/revslider/sr6/assets/assets/transparent.png" data-bg="c:#f9f7f3;" data-parallax="off" data-no-retina>
<!--
							--><rs-group
								id="slider-150-slide-676-layer-3" 
								data-type="group"
								data-rsp_ch="on"
								data-xy="x:l,l,l,c;xo:175px,50px,15px,0;y:m,m,m,t;yo:0,0,0,40px;"
								data-text="w:normal;s:20,12,9,5;l:0,16,12,7;"
								data-dim="w:460px,380px,350px,300px;h:300px,280px,250px,200px;"
								data-frame_0="o:1;"
								data-frame_999="o:0;st:w;sA:9000;"
								style="z-index:7;"
							><!--
								--><a
									id="slider-150-slide-676-layer-6" 
									class="rs-layer button-slider"
									href="Shop.aspx" target="_self"
									data-type="button"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;yo:238px,208px,189px,113px;"
									data-pos="a"
									data-text="w:normal;s:15;l:51,48,45,40;fw:700;"
									data-padding="r:50,45,45,40;l:50,45,45,40;"
									data-border="bor:5px,5px,5px,5px;"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:1200;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									data-frame_hover="c:#fff;bgc:#000;bor:5px,5px,5px,5px;"
									style="z-index:8;background-color:#ffb300;font-family:'Plus Jakarta Sans';"
								>Shop Now 
								</a><!--

								--><rs-layer
									id="slider-150-slide-676-layer-5" 
									data-type="text"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;yo:150px,131px,113px,104px;"
									data-pos="a"
									data-text="w:normal;s:28,25,22,18;l:35,30,30,25;fw:700;"
									data-vbility="t,t,t,f"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:1000;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									style="z-index:7;font-family:'Plus Jakarta Sans';"
								>Flat 20% off. on all Digital 
								</rs-layer><!--

								--><rs-layer
									id="slider-150-slide-676-layer-4" 
									data-type="text"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;"
									data-pos="a"
									data-text="w:normal;s:54,45,40,35;l:62,60,50,45;fw:700;a:left,left,left,center;"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:630;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									style="z-index:6;font-family:'Plus Jakarta Sans';"
								>Feel the Sound<br>Apple Home Mini 
								</rs-layer><!--
							--></rs-group><!--

							--><rs-layer
								id="slider-150-slide-676-layer-2" 
								data-type="image"
								data-rsp_ch="on"
								data-xy="x:r,r,r,c;y:m,m,m,b;yo:23px,14px,10px,0;"
								data-text="w:normal;s:20,12,9,5;l:0,16,12,7;"
								data-dim="w:869px,559px,419px,393px;h:398px,256px,192px,180px;"
								data-frame_0="sX:2;sY:2;"
								data-frame_0_mask="u:t;"
								data-frame_1="e:power2.out;st:360;sp:1200;"
								data-frame_1_mask="u:t;"
								data-frame_999="o:0;st:w;"
								style="z-index:6;"
							><img loading="lazy" decoding="async" src="../wp-content/plugins/revslider/sr6/assets/assets/dummy.png" alt="" class="tp-rs-img rs-lazyload" width="869" height="398" data-lazyload="//arostore.wpbingosite.com/wp-content/uploads/2023/04/img-12.png" data-no-retina> 
							</rs-layer><!--
-->					</rs-slide>
						<rs-slide style="position: absolute;" data-key="rs-856" data-title="Slide" data-thumb="//arostore.wpbingosite.com/wp-content/uploads/2022/12/slider-9.jpg" data-in="o:1;" data-out="y:-100%;" data-alttrans="boxfade,boxslide" data-p1="01">
							<img decoding="async" src="../wp-content/plugins/revslider/sr6/assets/assets/dummy.png" alt="Slide" class="rev-slidebg tp-rs-img rs-lazyload" data-lazyload="//arostore.wpbingosite.com/wp-content/plugins/revslider/sr6/assets/assets/transparent.png" data-bg="c:#f9f7f3;" data-parallax="off" data-no-retina>
<!--
							--><rs-group
								id="slider-150-slide-856-layer-3" 
								data-type="group"
								data-rsp_ch="on"
								data-xy="x:l,l,l,c;xo:175px,50px,15px,0;y:m,m,m,t;yo:0,0,0,40px;"
								data-text="w:normal;s:20,12,9,5;l:0,16,12,7;"
								data-dim="w:500px,380px,350px,300px;h:300px,280px,250px,200px;"
								data-frame_0="o:1;"
								data-frame_999="o:0;st:w;sA:9000;"
								style="z-index:7;"
							><!--
								--><a
									id="slider-150-slide-856-layer-6" 
									class="rs-layer button-slider"
									href="Shop.aspx" target="_self"
									data-type="button"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;yo:238px,208px,189px,113px;"
									data-pos="a"
									data-text="w:normal;s:15;l:51,48,45,40;fw:700;"
									data-padding="r:50,45,45,40;l:50,45,45,40;"
									data-border="bor:5px,5px,5px,5px;"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:1200;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									data-frame_hover="c:#fff;bgc:#000;bor:5px,5px,5px,5px;"
									style="z-index:8;background-color:#ffb300;font-family:'Plus Jakarta Sans';"
								>Shop Now 
								</a><!--

								--><rs-layer
									id="slider-150-slide-856-layer-5" 
									data-type="text"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;yo:150px,131px,113px,104px;"
									data-pos="a"
									data-text="w:normal;s:28,25,22,18;l:35,30,30,25;fw:700;"
									data-vbility="t,t,t,f"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:1000;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									style="z-index:7;font-family:'Plus Jakarta Sans';"
								>Flat 20% off. on all Digital 
								</rs-layer><!--

								--><rs-layer
									id="slider-150-slide-856-layer-4" 
									data-type="text"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;"
									data-pos="a"
									data-text="w:normal;s:54,45,40,35;l:62,60,50,45;fw:700;a:left,left,left,center;"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:630;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									style="z-index:6;font-family:'Plus Jakarta Sans';"
								>New Style<br>Bluetooth Speaker 
								</rs-layer><!--
							--></rs-group><!--

							--><rs-layer
								id="slider-150-slide-856-layer-2" 
								data-type="image"
								data-rsp_ch="on"
								data-xy="x:r,r,r,c;xo:50px,32px,24px,0;y:m,m,m,b;yo:23px,14px,10px,0;"
								data-text="w:normal;s:20,12,9,5;l:0,16,12,7;"
								data-dim="w:664px,427px,320px,393px;h:390px,251px,188px,180px;"
								data-frame_0="sX:2;sY:2;"
								data-frame_0_mask="u:t;"
								data-frame_1="e:power2.out;st:360;sp:1200;"
								data-frame_1_mask="u:t;"
								data-frame_999="o:0;st:w;"
								style="z-index:6;"
							><img loading="lazy" decoding="async" src="../wp-content/plugins/revslider/sr6/assets/assets/dummy.png" alt="" class="tp-rs-img rs-lazyload" width="664" height="390" data-lazyload="//arostore.wpbingosite.com/wp-content/uploads/2023/04/img-13.png" data-no-retina> 
							</rs-layer><!--
-->					</rs-slide>
						<rs-slide style="position: absolute;" data-key="rs-857" data-title="Slide" data-thumb="//arostore.wpbingosite.com/wp-content/uploads/2022/12/slider-9.jpg" data-in="o:1;" data-out="y:-100%;" data-alttrans="boxfade,boxslide" data-p1="01">
							<img decoding="async" src="../wp-content/plugins/revslider/sr6/assets/assets/dummy.png" alt="Slide" class="rev-slidebg tp-rs-img rs-lazyload" data-lazyload="//arostore.wpbingosite.com/wp-content/plugins/revslider/sr6/assets/assets/transparent.png" data-bg="c:#f9f7f3;" data-parallax="off" data-no-retina>
<!--
							--><rs-group
								id="slider-150-slide-857-layer-3" 
								data-type="group"
								data-rsp_ch="on"
								data-xy="x:l,l,l,c;xo:175px,50px,15px,0;y:m,m,m,t;yo:0,0,0,30px;"
								data-text="w:normal;s:20,12,9,5;l:0,16,12,7;"
								data-dim="w:600px,500px,450px,400px;h:300px,280px,250px,200px;"
								data-frame_0="o:1;"
								data-frame_999="o:0;st:w;sA:9000;"
								style="z-index:7;"
							><!--
								--><a
									id="slider-150-slide-857-layer-6" 
									class="rs-layer button-slider"
									href="Shop.aspx" target="_self"
									data-type="button"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;yo:238px,217px,198px,113px;"
									data-pos="a"
									data-text="w:normal;s:15;l:51,48,45,40;fw:700;"
									data-padding="r:50,45,45,40;l:50,45,45,40;"
									data-border="bor:5px,5px,5px,5px;"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:1200;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									data-frame_hover="c:#fff;bgc:#000;bor:5px,5px,5px,5px;"
									style="z-index:8;background-color:#ffb300;font-family:'Plus Jakarta Sans';"
								>Shop Now 
								</a><!--

								--><rs-layer
									id="slider-150-slide-857-layer-5" 
									data-type="text"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;yo:150px,141px,122px,104px;"
									data-pos="a"
									data-text="w:normal;s:28,25,22,18;l:35,30,30,25;fw:700;"
									data-vbility="t,t,t,f"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:1000;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									style="z-index:7;font-family:'Plus Jakarta Sans';"
								>Flat 20% off. on all Digital 
								</rs-layer><!--

								--><rs-layer
									id="slider-150-slide-857-layer-4" 
									data-type="text"
									data-color="#000000"
									data-rsp_ch="on"
									data-xy="x:l,l,l,c;"
									data-pos="a"
									data-text="w:normal;s:54,45,40,35;l:75,65,55,45;fw:700;a:left,left,left,center;"
									data-frame_0="y:-100%;"
									data-frame_0_mask="u:t;"
									data-frame_1="st:630;sp:1200;"
									data-frame_1_mask="u:t;"
									data-frame_999="o:0;st:w;"
									style="z-index:6;font-family:'Plus Jakarta Sans';"
								>Headphone<br>Spring Sale is Coming 
								</rs-layer><!--
							--></rs-group><!--

							--><rs-layer
								id="slider-150-slide-857-layer-2" 
								data-type="image"
								data-rsp_ch="on"
								data-xy="x:r,r,r,c;xo:50px,52px,39px,0;y:m,m,m,b;yo:23px,14px,10px,0;"
								data-text="w:normal;s:20,12,9,5;l:0,16,12,7;"
								data-dim="w:517px,332px,249px,250px;h:427px,274px,205px,206px;"
								data-frame_0="sX:2;sY:2;"
								data-frame_0_mask="u:t;"
								data-frame_1="e:power2.out;st:360;sp:1200;"
								data-frame_1_mask="u:t;"
								data-frame_999="o:0;st:w;"
								style="z-index:6;"
							><img loading="lazy" decoding="async" src="../wp-content/plugins/revslider/sr6/assets/assets/dummy.png" alt="" class="tp-rs-img rs-lazyload" width="517" height="427" data-lazyload="//arostore.wpbingosite.com/wp-content/uploads/2023/04/img-14.png" data-no-retina> 
							</rs-layer><!--
-->					</rs-slide>
					</rs-slides>
				</rs-module>
				<script>
				    setREVStartSize({ c: 'rev_slider_150_1', rl: [1240, 1200, 778, 480], el: [558, 500, 450, 400], gw: [1590, 1024, 768, 480], gh: [558, 500, 450, 400], type: 'standard', justify: '', layout: 'fullwidth', mh: "0" }); if (window.RS_MODULES !== undefined && window.RS_MODULES.modules !== undefined && window.RS_MODULES.modules["revslider1501"] !== undefined) { window.RS_MODULES.modules["revslider1501"].once = false; window.revapi150 = undefined; if (window.RS_MODULES.checkMinimal !== undefined) window.RS_MODULES.checkMinimal() }
				</script>
			</rs-module-wrap>
                                                            <!-- END REVOLUTION SLIDER -->
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                                <section class="elementor-section elementor-top-section elementor-element elementor-element-4622324 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="4622324" data-element_type="section">
                                    <div class="elementor-container elementor-column-gap-default">
                                        <div class="elementor-column elementor-col-100 elementor-top-column elementor-element elementor-element-b091a26" data-id="b091a26" data-element_type="column">
                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                <section class="elementor-section elementor-inner-section elementor-element elementor-element-cfd70ce elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="cfd70ce" data-element_type="section">
                                                    <div class="elementor-container elementor-column-gap-default">
                                                        <div class="elementor-column elementor-col-20 elementor-inner-column elementor-element elementor-element-63a7ed9 wpb-col-sm-50" data-id="63a7ed9" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-6f091a5 elementor-position-left elementor-vertical-align-middle vertical-center elementor-view-default elementor-mobile-position-top elementor-widget elementor-widget-icon-box" data-id="6f091a5" data-element_type="widget" data-widget_type="icon-box.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-icon-box-wrapper bwp-icon-box-wrapper">
                                                                            <div class="bwp-icon-box-icon">
                                                                                <span class="elementor-icon elementor-animation-grow">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" width="512" height="512" x="0" y="0" viewBox="0 0 24 24" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
                                                                                        <g>
                                                                                            <path d="M12 1a11 11 0 1 0 11 11A11.013 11.013 0 0 0 12 1zm0 20a9 9 0 1 1 9-9 9.011 9.011 0 0 1-9 9z" fill="" data-original="" class=""></path>
                                                                                            <path d="M13 11.586V6a1 1 0 0 0-2 0v6a1 1 0 0 0 .293.707l3 3a1 1 0 0 0 1.414-1.414z" fill="" data-original="" class=""></path>
                                                                                        </g></svg>
                                                                                </span>
                                                                            </div>
                                                                            <div class="elementor-icon-box-content">
                                                                                <h3 class="elementor-icon-box-title">
                                                                                    <span>Free shipping for all orders					</span>
                                                                                </h3>
                                                                                <p class="elementor-icon-box-description">
                                                                                    Order On $70				
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="elementor-column elementor-col-20 elementor-inner-column elementor-element elementor-element-66d62bc wpb-col-sm-50" data-id="66d62bc" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-097e710 elementor-position-left elementor-vertical-align-middle vertical-center elementor-view-default elementor-mobile-position-top elementor-widget elementor-widget-icon-box" data-id="097e710" data-element_type="widget" data-widget_type="icon-box.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-icon-box-wrapper bwp-icon-box-wrapper">
                                                                            <div class="bwp-icon-box-icon">
                                                                                <span class="elementor-icon elementor-animation-grow">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" width="512" height="512" x="0" y="0" viewBox="0 0 24 24" style="enable-background: new 0 0 512 512" xml:space="preserve">
                                                                                        <g>
                                                                                            <g data-name="Layer 2">
                                                                                                <path d="M18 22.752a2.739 2.739 0 0 1-1.65-.552l-4.2-3.15a.249.249 0 0 0-.3 0l-4.2 3.15a2.75 2.75 0 0 1-4.4-2.2V4.5A3.254 3.254 0 0 1 6.5 1.25h11a3.254 3.254 0 0 1 3.25 3.25V20A2.758 2.758 0 0 1 18 22.752zM17.25 21a1.25 1.25 0 0 0 2-1V4.5a1.752 1.752 0 0 0-1.75-1.75h-11A1.752 1.752 0 0 0 4.75 4.5V20a1.25 1.25 0 0 0 2 1l4.2-3.15a1.758 1.758 0 0 1 2.1 0z" fill="" data-original=""></path>
                                                                                                <path d="M15 7.75H9a.75.75 0 0 1 0-1.5h6a.75.75 0 0 1 0 1.5z" fill="" data-original=""></path>
                                                                                            </g>
                                                                                        </g></svg>
                                                                                </span>
                                                                            </div>
                                                                            <div class="elementor-icon-box-content">
                                                                                <h3 class="elementor-icon-box-title">
                                                                                    <span>Easy refund & refunds policy					</span>
                                                                                </h3>
                                                                                <p class="elementor-icon-box-description">
                                                                                    Within 30 days				
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="elementor-column elementor-col-20 elementor-inner-column elementor-element elementor-element-87113bc wpb-col-sm-50" data-id="87113bc" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-2224f99 elementor-position-left elementor-vertical-align-middle vertical-center elementor-view-default elementor-mobile-position-top elementor-widget elementor-widget-icon-box" data-id="2224f99" data-element_type="widget" data-widget_type="icon-box.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-icon-box-wrapper bwp-icon-box-wrapper">
                                                                            <div class="bwp-icon-box-icon">
                                                                                <span class="elementor-icon elementor-animation-grow">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" width="512" height="512" x="0" y="0" viewBox="0 0 24 24" style="enable-background: new 0 0 512 512" xml:space="preserve">
                                                                                        <g>
                                                                                            <path d="M18 3.25H6C3.38 3.25 1.25 5.38 1.25 8v8c0 2.62 2.13 4.75 4.75 4.75h12c2.62 0 4.75-2.13 4.75-4.75V8c0-2.62-2.13-4.75-4.75-4.75zM6 4.75h12c1.79 0 3.25 1.46 3.25 3.25v.25H2.75V8c0-1.79 1.46-3.25 3.25-3.25zm12 14.5H6c-1.79 0-3.25-1.46-3.25-3.25V9.75h18.5V16c0 1.79-1.46 3.25-3.25 3.25z" fill="" data-original=""></path>
                                                                                            <path d="M18 16.75h-3c-.41 0-.75-.34-.75-.75s.34-.75.75-.75h3c.41 0 .75.34.75.75s-.34.75-.75.75z" fill="" data-original=""></path>
                                                                                        </g></svg>
                                                                                </span>
                                                                            </div>
                                                                            <div class="elementor-icon-box-content">
                                                                                <h3 class="elementor-icon-box-title">
                                                                                    <span>Secured card payments					</span>
                                                                                </h3>
                                                                                <p class="elementor-icon-box-description">
                                                                                    100% secure payment				
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="elementor-column elementor-col-20 elementor-inner-column elementor-element elementor-element-f53dcfb wpb-col-sm-50" data-id="f53dcfb" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-0307a5f elementor-position-left elementor-vertical-align-middle vertical-center elementor-view-default elementor-mobile-position-top elementor-widget elementor-widget-icon-box" data-id="0307a5f" data-element_type="widget" data-widget_type="icon-box.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-icon-box-wrapper bwp-icon-box-wrapper">
                                                                            <div class="bwp-icon-box-icon">
                                                                                <span class="elementor-icon elementor-animation-grow">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" width="512" height="512" x="0" y="0" viewBox="0 0 24 24" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
                                                                                        <g>
                                                                                            <g fill="" fill-rule="evenodd" clip-rule="evenodd">
                                                                                                <path d="M16.09 9.097a.75.75 0 0 1 0 1.06l-4.746 4.746a.75.75 0 0 1-1.06 0L7.91 12.53a.75.75 0 1 1 1.06-1.06l1.844 1.842 4.216-4.215a.75.75 0 0 1 1.06 0z" fill="" data-original=""></path>
                                                                                                <path d="M4.243 4.243C5.911 2.576 8.49 2 12 2s6.089.576 7.757 2.243C21.424 5.911 22 8.49 22 12s-.576 6.089-2.243 7.757C18.089 21.425 15.51 22 12 22s-6.09-.575-7.757-2.243S2 15.51 2 12s.575-6.089 2.243-7.757zm1.06 1.061C4.082 6.527 3.5 8.574 3.5 12s.58 5.473 1.804 6.696C6.527 19.92 8.573 20.5 12 20.5c3.427 0 5.473-.58 6.696-1.804C19.919 17.473 20.5 15.427 20.5 12s-.581-5.473-1.804-6.696C17.473 4.081 15.426 3.5 12 3.5c-3.427 0-5.473.581-6.696 1.804z" fill="" data-original=""></path>
                                                                                            </g>
                                                                                        </g></svg>
                                                                                </span>
                                                                            </div>
                                                                            <div class="elementor-icon-box-content">
                                                                                <h3 class="elementor-icon-box-title">
                                                                                    <span>100% Free Warranty					</span>
                                                                                </h3>
                                                                                <p class="elementor-icon-box-description">
                                                                                    Applies to all customers				
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="elementor-column elementor-col-20 elementor-inner-column elementor-element elementor-element-0f5eaa2 hidden-sm" data-id="0f5eaa2" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-990ebb1 elementor-position-left elementor-vertical-align-middle vertical-center elementor-view-default elementor-mobile-position-top elementor-widget elementor-widget-icon-box" data-id="990ebb1" data-element_type="widget" data-widget_type="icon-box.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-icon-box-wrapper bwp-icon-box-wrapper">
                                                                            <div class="bwp-icon-box-icon">
                                                                                <span class="elementor-icon elementor-animation-grow">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" width="512" height="512" x="0" y="0" viewBox="0 0 24 24" style="enable-background: new 0 0 512 512" xml:space="preserve">
                                                                                        <g>
                                                                                            <path d="M15 2H9C5.2 2 2 5.2 2 9v6c0 3.9 3.2 7 7 7h6c3.9 0 7-3.2 7-7V9c0-3.8-3.2-7-7-7zm5.5 13c0 3.1-2.5 5.5-5.5 5.5H9c-3 0-5.5-2.5-5.5-5.5V9C3.5 6 6 3.5 9 3.5h6c3 0 5.5 2.5 5.5 5.5z" fill="" data-original=""></path>
                                                                                            <path d="M11.3 9.6c0-1.2-1-2.1-2.2-2.1S7 8.4 7 9.6s1 2.1 2.2 2.1 2.1-1 2.1-2.1zm-2.8 0c0-.3.3-.6.7-.6s.7.3.7.6-.3.6-.7.6-.7-.3-.7-.6zM14.8 12.3c-1.2 0-2.2.9-2.2 2.1s1 2.1 2.2 2.1 2.2-.9 2.2-2.1-1-2.1-2.2-2.1zm0 2.7c-.4 0-.7-.3-.7-.6s.3-.6.7-.6.7.3.7.6-.3.6-.7.6zM16 7.2c-.4-.2-.8-.2-1.1.1l-6.8 8.4c-.3.3-.2.8.1 1.1.1.1.3.2.5.2s.4-.1.6-.3l6.8-8.4c.2-.3.2-.8-.1-1.1z" fill="" data-original=""></path>
                                                                                        </g></svg>
                                                                                </span>
                                                                            </div>
                                                                            <div class="elementor-icon-box-content">
                                                                                <h3 class="elementor-icon-box-title">
                                                                                    <span>Fast & safe delivery all over					</span>
                                                                                </h3>
                                                                                <p class="elementor-icon-box-description">
                                                                                    Deliver in 24 hours max!				
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                                <section class="elementor-section elementor-top-section elementor-element elementor-element-107d5b0 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="107d5b0" data-element_type="section">
                                    <div class="elementor-container elementor-column-gap-default">
                                        <div class="elementor-column elementor-col-33 elementor-top-column elementor-element elementor-element-5e72353" data-id="5e72353" data-element_type="column">
                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                <div class="elementor-element elementor-element-2d028b3 elementor-widget elementor-widget-bwp_image" data-id="2d028b3" data-element_type="widget" data-widget_type="bwp_image.default">
                                                    <div class="elementor-widget-container">
                                                        <div class="bwp-widget-banner default">

                                                            <div class="bg-banner">
                                                                <div class="banner-wrapper banners">
                                                                    <div class="bwp-image">
                                                                        <a href="Shop.aspx">
                                                                            <img decoding="async" src="../wp-content/uploads/2023/04/banner-18.jpg" alt="Banner Image"></a>
                                                                    </div>
                                                                    <div class="banner-wrapper-infor">
                                                                        <div class="info">
                                                                            <div class="bwp-image-subtitle">
                                                                                Starts at $890.9						
                                                                            </div>
                                                                            <h3 class="title-banner">Apple Kit’s<br>
                                                                                Iphone  15 Infinite</h3>
                                                                            <a class="button" href="Shop.aspx">Shop Now</a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="elementor-column elementor-col-33 elementor-top-column elementor-element elementor-element-d8373d3" data-id="d8373d3" data-element_type="column">
                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                <div class="elementor-element elementor-element-991df1d elementor-widget elementor-widget-bwp_image" data-id="991df1d" data-element_type="widget" data-widget_type="bwp_image.default">
                                                    <div class="elementor-widget-container">
                                                        <div class="bwp-widget-banner default">

                                                            <div class="bg-banner">
                                                                <div class="banner-wrapper banners">
                                                                    <div class="bwp-image">
                                                                        <a href="Shop.aspx">
                                                                            <img decoding="async" src="../wp-content/uploads/2023/04/banner-19.jpg" alt="Banner Image"></a>
                                                                    </div>
                                                                    <div class="banner-wrapper-infor">
                                                                        <div class="info">
                                                                            <div class="bwp-image-subtitle">
                                                                                Free Shipping 						
                                                                            </div>
                                                                            <h3 class="title-banner">Xbox Wireless<br>
                                                                                Sale Up To 50% Off</h3>
                                                                            <a class="button" href="Shop.aspx">Shop Now</a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="elementor-column elementor-col-33 elementor-top-column elementor-element elementor-element-2211f70" data-id="2211f70" data-element_type="column">
                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                <div class="elementor-element elementor-element-acfa296 elementor-widget elementor-widget-bwp_image" data-id="acfa296" data-element_type="widget" data-widget_type="bwp_image.default">
                                                    <div class="elementor-widget-container">
                                                        <div class="bwp-widget-banner default">

                                                            <div class="bg-banner">
                                                                <div class="banner-wrapper banners">
                                                                    <div class="bwp-image">
                                                                        <a href="Shop.aspx">
                                                                            <img decoding="async" src="../wp-content/uploads/2023/04/banner-20.jpg" alt="Banner Image"></a>
                                                                    </div>
                                                                    <div class="banner-wrapper-infor">
                                                                        <div class="info">
                                                                            <div class="bwp-image-subtitle">
                                                                                Limited Time!						
                                                                            </div>
                                                                            <h3 class="title-banner">For Cellular<br>
                                                                                Apple I Watch S8</h3>
                                                                            <a class="button" href="Shop.aspx">Shop Now</a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                                <section class="elementor-section elementor-top-section elementor-element elementor-element-f230951 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="f230951" data-element_type="section" data-settings="{&quot;background_background&quot;:&quot;classic&quot;}">
                                    <div class="elementor-container elementor-column-gap-default">
                                        <div class="elementor-column elementor-col-100 elementor-top-column elementor-element elementor-element-3a68ff8" data-id="3a68ff8" data-element_type="column">
                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                <section class="elementor-section elementor-inner-section elementor-element elementor-element-8d2e9b5 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="8d2e9b5" data-element_type="section">
                                                    <div class="elementor-container elementor-column-gap-default">
                                                        <div class="elementor-column elementor-col-100 elementor-inner-column elementor-element elementor-element-95c766f" data-id="95c766f" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-9588993 elementor-widget elementor-widget-bwp_product_list" data-id="9588993" data-element_type="widget" data-widget_type="bwp_product_list.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div id="bwp_default_8200146671770017402" class="bwp_product_list 1 bwp_slick-margin-mobile list-deal ">
                                                                            <div class="content-heading">
                                                                                <div class="title-block">
                                                                                    <h2>Deals Of The Day</h2>
                                                                                </div>
                                                                                <div class="countdown-deal">
                                                                                    <label>Hurry Up! Offer ends in: </label>
                                                                                    <div class="product-countdown"
                                                                                        data-day="day"
                                                                                        data-hour="hours"
                                                                                        data-min="min"
                                                                                        data-sec="sec"
                                                                                        data-date="1812240000"
                                                                                        data-sttime="1770017402"
                                                                                        data-cdtime="1812240000"
                                                                                        data-id="bwp_default_8200146671770017402">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="list-product">
                                                                                <div class="product-content">
                                                                                    <div class="content-product-list navigation-show navigational_default">
                                                                                        <div class="slider products-list grid slick-carousel" data-slidestoscroll="true" data-dots="false" data-nav="1" data-columns4="1" data-columns3="2" data-columns2="2" data-columns1="3" data-columns1440="4" data-columns="4">
                                                                                            <asp:Repeater ID="rptDeals" runat="server">
<ItemTemplate>

<div class="item-product">
    <div class="items">
        <div class="products-entry content-product2 clearfix product-wapper">

            <div class="products-thumb">

                <div class="product-lable">
                         </div>

                <div class="product-thumb-hover">
                    <a href='ProductDetails.aspx?id=<%# Eval("ProductID") %>'>
                        <img src='../Uploads/ProductImages/<%# Eval("MainImage") %>' class="wp-post-image" />
                        <img src='../Uploads/ProductImages/<%# Eval("HoverImage") %>' class="hover-image back" />
                    </a>
                </div>

        <div class="product-actions">

    <!-- ❤️ Wishlist -->
    <button type="button"
        class='wishlist-btn <%# UserWishlist.Contains(Convert.ToInt32(Eval("ProductID"))) ? "active" : "" %>'
        data-pid="<%# Eval("ProductID") %>"
        onclick="toggleWishlist(this)">
        ❤
    </button>

    <!-- 👁 Quickview (ICON ONLY) -->
    <button type="button"
            class="quickview-btn"
            onclick="openQuickView(<%# Eval("ProductID") %>)">
        🔍
    </button>

</div>


            </div>

            <div class="products-content">
                <div class="contents">

                    <div class="cat-products">
                        <%# Eval("CategoryName") %>
                    </div>

                    <h3 class="product-title">
                        <a href='ProductDetails.aspx?id=<%# Eval("ProductID") %>'>
                            <%# Eval("ProductName") %>
                        </a>
                    </h3>

                    <div class="available-box">
                        <label>Available:</label> <%# Eval("Stock") %>
                    </div>

                    <span class="price">
                       <span class="price">
    ₹<%# Eval("Price") %>
</span>

                    </span>

                    

                     <div class="product-cart">
                      <div data-title="Buy product">
                          <a rel="nofollow" href="ProductDetails.aspx?pid=<%# Eval("ProductID") %>" data-quantity="1" data-product_id="16541" data-product_sku="D2300-3-2-3" class="button product_type_external read_more"><span>Buy product</span></a></div>
                      </div>

                </div>
            </div>

        </div>
    </div>
</div>

</ItemTemplate>
</asp:Repeater>

                                                                                    
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                                <section class="elementor-section elementor-inner-section elementor-element elementor-element-39c59e7 section-one elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="39c59e7" data-element_type="section" data-settings="{&quot;background_background&quot;:&quot;classic&quot;}">
                                                    <div class="elementor-container elementor-column-gap-default">
                                                        <div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-c4b7398" data-id="c4b7398" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-78fb71e elementor-widget elementor-widget-heading" data-id="78fb71e" data-element_type="widget" data-widget_type="heading.default">
                                                                    <div class="elementor-widget-container">
                                                                        <h2 class="elementor-heading-title elementor-size-default">Shop By Category</h2>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-cfda0ad" data-id="cfda0ad" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-4e5327a elementor-align-right elementor-mobile-align-center elementor-widget elementor-widget-button" data-id="4e5327a" data-element_type="widget" data-widget_type="button.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-button-wrapper">
                                                                            <a class="elementor-button elementor-button-link elementor-size-sm" href="Categories.aspx">
                                                                                <span class="elementor-button-content-wrapper">
                                                                                    <span class="elementor-button-text">View all Category</span>
                                                                                </span>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                                <section class="elementor-section elementor-inner-section elementor-element elementor-element-466b807 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="466b807" data-element_type="section">
                                                    <div class="elementor-container elementor-column-gap-default">
                                                        <div class="elementor-column elementor-col-25 elementor-inner-column elementor-element elementor-element-abcbb24" data-id="abcbb24" data-element_type="column" data-settings="{&quot;background_background&quot;:&quot;classic&quot;}">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-4aacf4e elementor-mobile-align-center elementor-widget elementor-widget-button" data-id="4aacf4e" data-element_type="widget" data-widget_type="button.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-button-wrapper">
                                                                            <a class="elementor-button elementor-size-sm" role="button">
                                                                                <span class="elementor-button-content-wrapper">
                                                                                    <span class="elementor-button-text">Get yours now.</span>
                                                                                </span>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="elementor-element elementor-element-1524d52 elementor-widget elementor-widget-heading" data-id="1524d52" data-element_type="widget" data-widget_type="heading.default">
                                                                    <div class="elementor-widget-container">
                                                                        <h2 class="elementor-heading-title elementor-size-default">Smart Speakers at<br>
                                                                            Low Cost</h2>
                                                                    </div>
                                                                </div>
                                                                <div class="elementor-element elementor-element-e557690 elementor-mobile-align-center elementor-widget elementor-widget-button" data-id="e557690" data-element_type="widget" data-widget_type="button.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-button-wrapper">
                                                                            <a class="elementor-button elementor-button-link elementor-size-sm" href="Categories.aspx">
                                                                                <span class="elementor-button-content-wrapper">
                                                                                    <span class="elementor-button-text">Shop Now</span>
                                                                                </span>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <div class="category-grid">

<asp:Repeater ID="rptCategories" runat="server" OnItemDataBound="rptCategories_ItemDataBound">
<ItemTemplate>

<div class="bwp-woo-categories list-category2">
    <div class="item-info">
        <h3 class="bwp-categories-title">
            <%# Eval("CategoryName") %>
        </h3>

        <asp:Repeater ID="rptSub" runat="server">
            <ItemTemplate>
                <div class="item">
                    <div class="item-title">
                        <a href='CategoryProducts.aspx?cid=<%# Eval("CategoryID") %>&sid=<%# Eval("SubCategoryID") %>'>
                            <span><%# Eval("SubCategoryName") %></span>
                        </a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>

    <div class="item-image">
        <img src='../Uploads/CategoryImages/<%# Eval("ImagePath") %>' alt="Category Image" />
    </div>
</div>

</ItemTemplate>
</asp:Repeater>


</div>


                                                    </div>
                                                </section>
                                                <section class="elementor-section elementor-inner-section elementor-element elementor-element-7dd0952 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="7dd0952" data-element_type="section">
                                                    <div class="elementor-container elementor-column-gap-default">
                                                        <div class="elementor-column elementor-col-100 elementor-inner-column elementor-element elementor-element-9ac7248" data-id="9ac7248" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-eda655a elementor-widget elementor-widget-bwp_filter_homepage" data-id="eda655a" data-element_type="widget" data-widget_type="bwp_filter_homepage.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="bwp-filter-homepage tab-category tab_category_default" data-content_product="3" data-class_col="col-xl-2-4 col-lg-4 col-md-4 col-12" data-numberposts="10">
                                                                            <div class="bwp-filter-heading">
                                                                                <div class="category-tab-nav">
                                                                                    <div class="title-block">
                                                                                        <h2>Popular Products</h2>
                                                                                    </div>
                                                                                    <ul class="filter-category">
                                                                                        <li class="category active" data-value="all">
                                                                                            <a href="Shop.aspx">
                                                                                            View all
                                                                                       </a>
                                                                                                 </li>
                                                                                       
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                            <div class="bwp-filter-content">
                                                                                <ul class="filter-orderby hidden">
                                                                                    <li data-value="date" class="active">date</li>
                                                                                </ul>
                                                                                <div class="content-product-list content-products-all">
                                                                                    <div class="content products-list grid row">
                                                                                      <asp:Repeater ID="rptPopularProducts" runat="server">
    <ItemTemplate>

        <div class="item col-xl-2-4 col-lg-4 col-md-4 col-12">
            <div class="item-product">
                <div class="products-entry content-product3 clearfix product-wapper">

                    <div class="products-thumb">

                        <div class="product-thumb-hover">
                            <a href='ProductDetails.aspx?pid=<%# Eval("ProductID") %>'
                               class="woocommerce-LoopProduct-link">

                                <!-- FRONT IMAGE -->
                                <img loading="lazy"
                                     decoding="async"
                                     width="600"
                                     height="600"
                                     src='<%# ResolveUrl("~/Uploads/ProductImages/") + Eval("MainImage") %>'
                                     class="fade-in lazyload wp-post-image"
                                     alt="" />

                                <!-- BACK IMAGE (SAME IMAGE – REQUIRED FOR HOVER) -->
                                <img loading="lazy"
                                     decoding="async"
                                     width="600"
                                     height="600"
                                     src='<%# ResolveUrl("~/Uploads/ProductImages/") + Eval("HoverImage") %>'
                                     class="hover-image back"
                                     alt="" />

                            </a>
                        </div>
     <div class="product-actions">

    <!-- ❤️ Wishlist -->
    <button type="button"
        class='wishlist-btn <%# UserWishlist.Contains(Convert.ToInt32(Eval("ProductID"))) ? "active" : "" %>'
        data-pid="<%# Eval("ProductID") %>"
        onclick="toggleWishlist(this)">
        ❤
    </button>

    <!-- 👁 Quickview (ICON ONLY) -->
    <button type="button"
            class="quickview-btn"
            onclick="openQuickView(<%# Eval("ProductID") %>)">
        🔍
    </button>

</div>



                    </div>

                    <div class="products-content">
                        <div class="contents">

                            <div class="cat-products">
                                <a href='CategoryProducts.aspx?cid=<%# Eval("CategoryID") %>'>
                                    <%# Eval("CategoryName") %>
                                </a>
                            </div>

                            <h3 class="product-title">
                                <a href='ProductDetails.aspx?pid=<%# Eval("ProductID") %>'>
                                    <%# Eval("ProductName") %>
                                </a>
                            </h3>

                            <span class="price">
                                <span class="woocommerce-Price-amount amount">
                                    ₹<%# Eval("Price") %>
                                </span>
                            </span>

                          

                        </div>
                    </div>

                </div>
            </div>
        </div>

    </ItemTemplate>
</asp:Repeater>

                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                                <section class="elementor-section elementor-inner-section elementor-element elementor-element-00d85a7 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="00d85a7" data-element_type="section" data-settings="{&quot;background_background&quot;:&quot;classic&quot;}">
                                                    <div class="elementor-container elementor-column-gap-default">
                                                        <div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-d8c27d3" data-id="d8c27d3" data-element_type="column">
                                                            <div class="elementor-widget-wrap">
                                                            </div>
                                                        </div>
                                                        <div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-ebac14b" data-id="ebac14b" data-element_type="column" data-settings="{&quot;background_background&quot;:&quot;classic&quot;}">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-9d211d8 elementor-widget elementor-widget-heading" data-id="9d211d8" data-element_type="widget" data-widget_type="heading.default">
                                                                    <div class="elementor-widget-container">
                                                                        <h2 class="elementor-heading-title elementor-size-default">Camera Quality 8K Ultra. Save 20% On Today’s</h2>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                                <section class="elementor-section elementor-inner-section elementor-element elementor-element-d8cb7b0 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="d8cb7b0" data-element_type="section">
                                                    <div class="elementor-container elementor-column-gap-default">
                                                        <div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-853b0e1 wpb-col-sm-40" data-id="853b0e1" data-element_type="column" data-settings="{&quot;background_background&quot;:&quot;classic&quot;}">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-efaa241 elementor-mobile-align-center elementor-widget elementor-widget-button" data-id="efaa241" data-element_type="widget" data-widget_type="button.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-button-wrapper">
                                                                            <a class="elementor-button elementor-size-sm" role="button">
                                                                                <span class="elementor-button-content-wrapper">
                                                                                    <span class="elementor-button-text">Shop Brands</span>
                                                                                </span>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="elementor-element elementor-element-33a2f64 elementor-widget elementor-widget-heading" data-id="33a2f64" data-element_type="widget" data-widget_type="heading.default">
                                                                    <div class="elementor-widget-container">
                                                                        <h2 class="elementor-heading-title elementor-size-default">Exclusive and limited<br>
                                                                            here!</h2>
                                                                    </div>
                                                                </div>
                                                                <div class="elementor-element elementor-element-1e7e294 elementor-mobile-align-center elementor-widget elementor-widget-button" data-id="1e7e294" data-element_type="widget" data-widget_type="button.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="elementor-button-wrapper">
                                                                            <a class="elementor-button elementor-button-link elementor-size-sm" href="Shop.aspx">
                                                                                <span class="elementor-button-content-wrapper">
                                                                                    <span class="elementor-button-text">from $309.00</span>
                                                                                </span>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="elementor-column elementor-col-50 elementor-inner-column elementor-element elementor-element-7829963 wpb-col-sm-60" data-id="7829963" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-22acc05 elementor-widget elementor-widget-bwp_brand" data-id="22acc05" data-element_type="widget" data-widget_type="bwp_brand.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div id="bwp_brand_10630513691770017402" class="bwp-brand default">
                                                                            <div class="brand-content-list">
                                                                                <div class="brand-content brand-list grid row">
                                                                                    <div class="item col-xl-4 col-lg-4 col-md-6 col-6">
                                                                                        <div class="item-image">
                                                                                            <a href="#">
                                                                                                <img decoding="async" class=" elementor-animation-wobble-horizontal" src="../wp-content/uploads/2023/04/brand-1.png" alt="Feedly"></a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="item col-xl-4 col-lg-4 col-md-6 col-6">
                                                                                        <div class="item-image">
                                                                                            <a href="#">
                                                                                                <img decoding="async" class=" elementor-animation-wobble-horizontal" src="../wp-content/uploads/2023/04/brand-2.png" alt="Hopin"></a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="item col-xl-4 col-lg-4 col-md-6 col-6">
                                                                                        <div class="item-image">
                                                                                            <a href="#">
                                                                                                <img decoding="async" class=" elementor-animation-wobble-horizontal" src="../wp-content/uploads/2023/04/brand-3.png" alt="Lattice"></a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="item col-xl-4 col-lg-4 col-md-6 col-6">
                                                                                        <div class="item-image">
                                                                                            <a href="#">
                                                                                                <img decoding="async" class=" elementor-animation-wobble-horizontal" src="../wp-content/uploads/2023/04/brand-6.png" alt="Rectak"></a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="item col-xl-4 col-lg-4 col-md-6 col-6">
                                                                                        <div class="item-image">
                                                                                            <a href="#">
                                                                                                <img decoding="async" class=" elementor-animation-wobble-horizontal" src="../wp-content/uploads/2023/04/brand-4.png" alt="Spotify"></a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="item col-xl-4 col-lg-4 col-md-6 col-6">
                                                                                        <div class="item-image">
                                                                                            <a href="#">
                                                                                                <img decoding="async" class=" elementor-animation-wobble-horizontal" src="../wp-content/uploads/2023/04/brand-5.png" alt="Upwork"></a>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>
                                                <section class="elementor-section elementor-inner-section elementor-element elementor-element-88da6e8 elementor-section-boxed elementor-section-height-default elementor-section-height-default" data-id="88da6e8" data-element_type="section">
                                                    <div class="elementor-container elementor-column-gap-default">
                                                        <div class="elementor-column elementor-col-100 elementor-inner-column elementor-element elementor-element-c526b0c" data-id="c526b0c" data-element_type="column">
                                                            <div class="elementor-widget-wrap elementor-element-populated">
                                                                <div class="elementor-element elementor-element-8868bb8 elementor-widget elementor-widget-bwp_filter_homepage" data-id="8868bb8" data-element_type="widget" data-widget_type="bwp_filter_homepage.default">
                                                                    <div class="elementor-widget-container">
                                                                        <div class="bwp-filter-homepage tab-category slider 1 bwp_slick-margin-mobile tab_category_slider" data-content_product="7" data-numberposts="6">
                                                                            <div class="box-content">
                                                                                <div class="bwp-filter-heading">
                                                                                    <div class="category-tab-nav">
                                                                                        <div class="title-block">
                                                                                            <h2>Top Selling Products</h2>
                                                                                        </div>
                                                                                        <ul class="filter-category">
                                                                                            <li class="category active" data-value="all">
                                                                                                <a href="Shop.aspx">View all</a>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="bwp-filter-content">
                                                                                    <ul class="filter-orderby hidden">
                                                                                        <li data-value="date" class="active">date</li>
                                                                                    </ul>
                                                                                    <div class="content-product-list content-products-all">
                                                                                        <div class="content products-list grid slick-carousel row" data-slidestoscroll="true" data-item_row="2" data-dots="0" data-nav="0" data-columns4="1" data-columns3="2" data-columns2="2" data-columns1="2" data-columns1440="2" data-columns="3">
                                                                                           <asp:Repeater ID="rptTopSelling" runat="server">
<ItemTemplate>

<div class="item">
    <div class="item-product">
        <div class="products-entry content-product7 clearfix product-wapper">

            <div class="products-thumb">

                <div class="product-thumb-hover">
                    <a href='ProductDetails.aspx?pid=<%# Eval("ProductID") %>' 
                       class="woocommerce-LoopProduct-link">

                        <!-- MAIN IMAGE -->
                        <img class="fade-in lazyload wp-post-image"
                             src='<%# "../Uploads/ProductImages/" + Eval("MainImage") %>'
                             alt='<%# Eval("ProductName") %>' />

                        <!-- HOVER IMAGE -->
                        <img class="hover-image back"
                             src='<%# "../Uploads/ProductImages/" + Eval("HoverImage") %>'
                             alt='<%# Eval("ProductName") %>' />
                    </a>
                </div>
            <div class="product-actions">

    <!-- ❤️ Wishlist -->
    <button type="button"
        class='wishlist-btn <%# UserWishlist.Contains(Convert.ToInt32(Eval("ProductID"))) ? "active" : "" %>'
        data-pid="<%# Eval("ProductID") %>"
        onclick="toggleWishlist(this)">
        ❤
    </button>

    <!-- 👁 Quickview (ICON ONLY) -->
    <button type="button"
            class="quickview-btn"
            onclick="openQuickView(<%# Eval("ProductID") %>)">
        🔍
    </button>

</div>


            </div>

            <div class="products-content">
                <div class="contents">

                    <div class="cat-products">
                        <a href='CategoryProducts.aspx?cid=<%# Eval("CategoryID") %>'>
                            <%# Eval("CategoryName") %>
                        </a>
                    </div>

                    <h3 class="product-title">
                        <a href='ProductDetails.aspx?pid=<%# Eval("ProductID") %>'>
                            <%# Eval("ProductName") %>
                        </a>
                    </h3>

                    <span class="price">
                        ₹ <%# Eval("Price") %>
                    </span>

                </div>

            </div>

        </div>
    </div>
</div>

</ItemTemplate>
</asp:Repeater>


                                                                                          

                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </section>

                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                        <!-- .entry-content -->
                    </article>
                    <!-- #post-## -->
                </div>
                <!-- #content -->
            </div>
            <!-- #primary -->
        </div>
        <!-- #main-content -->
    </div>
    <!-- #main -->


    <script>
        function toggleWishlist(btn) {

            var pid = btn.getAttribute("data-pid");
            console.log("PID:", pid);

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "<%= ResolveUrl("~/Client/Handlers/WishlistHandler.ashx") %>", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            console.log("STATUS:", xhr.status);
            console.log("RESPONSE:", xhr.responseText);
        }
    };

    xhr.send("pid=" + pid);
}
</script>



</asp:Content>

