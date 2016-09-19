<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
	<?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
	<?php if ($column_left && $column_right) { ?>
	<?php $class = 'col-sm-6'; ?>
	<?php } elseif ($column_left || $column_right) { ?>
	<?php $class = 'col-sm-9'; ?>
	<?php } else { ?>
	<?php $class = 'col-sm-12'; ?>
	<?php } ?>
	<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
	  <h2><?php echo $heading_title; ?></h2>
	  <?php if ($thumb || $description) { ?>
	  <div class="row">
		<?php if ($thumb) { ?>
		<div class="col-sm-3">
			<div class="image">
				<img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" />
			</div>
			<br>
		</div>
		<?php } ?>
		<?php if ($description) { ?>
		<div class="col-sm-9"><?php echo $description; ?></div>
		<?php } ?>
	  </div>
	  <br>
	  <?php } ?>
	  <?php if ($categories) { ?>
	  <h3><?php echo $text_refine; ?></h3>
	  
	  <div class="row">
		<div >
		  <ul class="box-subcat">
			<?php $i=0; foreach ($categories as $category) { $i++; ?>
				<?php 
			   $perLine = 4;
			   $last_line = "";
							$total = count($products);
							$totModule = $total%$perLine;
							if ($totModule == 0)  { $totModule = $perLine;}
							if ( $i > $total - $totModule) { $last_line = " last_line";}
							if ($i%$perLine==1) {
								$a='first-in-line';
							}
							elseif ($i%$perLine==0) {
								$a='last-in-line';
							}
							else {
								$a='';
							}
						?>
			<li class="col-sm-3  <?php echo $a. $last_line ;?>">
                <div class="thumb">
				<?php if ($category['thumb']) { ?>
					<div class="image"><a href="<?php echo $category['href']; ?>"><img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" /></a></div>
				<?php } ?>
				<div class="name subcatname"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></div>
                </div>
			</li>
			<?php } ?>
		  </ul>
		</div>
	  </div>
	  
	  <?php } ?>
	  <?php if ($products) { ?>
		<div class="product-filter clearfix">
            <div class="product-filter_elem">
                <div class="button-view">
                    <button type="button" id="list-view" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="material-design-view12"></i></button>
                    <button type="button" id="grid-view" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="material-design-two375"></i></button>
                </div>
            </div>
				<div class="product-filter_elem sort">
					<label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
                    <select id="input-sort" class="form-control col-sm-3" onchange="location = this.value;">
                        <?php foreach ($sorts as $sorts) { ?>
                            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                                <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                            <?php } else { ?>
                                <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                            <?php } ?>
                        <?php } ?>
                    </select>
				</div>
            <div class="product-filter_elem show pull-right">
                <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
                <select id="input-limit" class="form-control" onchange="location = this.value;">
                    <?php foreach ($limits as $limits) { ?>
                        <?php if ($limits['value'] == $limit) { ?>
                            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                        <?php } else { ?>
                            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                        <?php } ?>
                    <?php } ?>
                </select>
            </div>
            <div class="product-filter_elem">
                <div class="button-view">
                <a href="<?php echo $compare; ?>" id="compare-total" class="compare-total material-design-shuffle24" data-toggle="tooltip" title="<?php echo $text_compare; ?>"><span><?php echo $text_compare; ?></span>
                </a>
                    </div>
            </div>


		</div>
	  <div class="row product-block">
		<?php $pr = 10000;  foreach ($products as $product) { $pr++?>
		<div class="product-layout product-list col-xs-12">
            <div class="product-thumb transition <?php if ($product['options']) echo 'options';  ?>">
			<div>
                <?php if ($product['options']) { ?>
                    <!-- Product options -->
                    <div class="product-option-wrap">
                        <div class="product-options form-horizontal">
                            <div class="options">
                                <a class="ajax-overlay_close" href='#'></a>
                                <h3><?php echo $text_option; ?></h3>

                                <div class="form-group hidden">
                                    <div class="col-sm-8">
                                        <input type="text"
                                               name="product_id"
                                               value="<?php echo $product['product_id'] ?>"
                                               class="form-control"/>
                                    </div>
                                </div>

                                <?php foreach ($product['options'] as $option) { ?>
                                    <?php if ($option['type'] == 'select') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label col-sm-12"
                                                   for="input-option<?php echo $option['product_option_id'] . $pr; ?>"><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <select
                                                    name="option[<?php echo $option['product_option_id']; ?>]"
                                                    id="input-option<?php echo $option['product_option_id'] . $pr; ?>"
                                                    class="form-control">
                                                    <option value=""><?php echo $text_select; ?></option>
                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                        <option
                                                            value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                            <?php if ($option_value['price']) { ?>
                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                            <?php } ?>
                                                        </option>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'radio') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label
                                                class="control-label col-sm-12"

                                                ><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <div
                                                    id="input-option<?php echo $option['product_option_id'] . $pr; ?>">
                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                        <div class="radio">
                                                            <label
                                                                for="option[<?php echo $option['product_option_id'] . $option_value['product_option_value_id'] . $pr; ?>]">
                                                                <input type="radio" hidden
                                                                       name="option[<?php echo $option['product_option_id']; ?>]"
                                                                       id="option[<?php echo $option['product_option_id'] . $option_value['product_option_value_id'] . $pr; ?>]"
                                                                       value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                                <?php echo $option_value['name']; ?>
                                                                <?php if ($option_value['price']) { ?>
                                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                <?php } ?>
                                                            </label>
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'checkbox') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label
                                                class="control-label col-sm-12
                                                "><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <div
                                                    id="input-option<?php echo $option['product_option_id'] . $pr; ?>">
                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                        <div class="checkbox">
                                                            <label>
                                                                <input type="checkbox"
                                                                       name="option[<?php echo $option['product_option_id']; ?>][]"
                                                                       value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                                <?php echo $option_value['name']; ?>
                                                                <?php if ($option_value['price']) { ?>
                                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                <?php } ?>
                                                            </label>
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'image') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label
                                                class="control-label col-sm-12
                                                "><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <div
                                                    id="input-option<?php echo $option['product_option_id'] . $pr; ?>">
                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio"
                                                                       name="option[<?php echo $option['product_option_id']; ?>]"
                                                                       value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                                <img src="<?php echo $option_value['image']; ?>"
                                                                     alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                                     class="img-thumbnail"/> <?php echo $option_value['name']; ?>
                                                                <?php if ($option_value['price']) { ?>
                                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                <?php } ?>
                                                            </label>
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'text') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label col-sm-12
                                            "
                                                   for="input-option<?php echo $option['product_option_id'] . $pr; ?>"><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <input type="text"
                                                       name="option[<?php echo $option['product_option_id']; ?>]"
                                                       value="<?php echo $option['value']; ?>"
                                                       placeholder="<?php echo $option['name']; ?>"
                                                       id="input-option<?php echo $option['product_option_id'] . $pr; ?>"
                                                       class="form-control"/>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'textarea') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label col-sm-12
                                            "
                                                   for="input-option<?php echo $option['product_option_id'] . $pr; ?>"><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                    <textarea name="option[<?php echo $option['product_option_id']; ?>]"
                                                              rows="5" placeholder="<?php echo $option['name']; ?>"
                                                              id="input-option<?php echo $option['product_option_id'] . $pr; ?>"
                                                              class="form-control"><?php echo $option['value']; ?></textarea>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'file') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label
                                                class="control-label col-sm-12
                                                "><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <button type="button"
                                                        id="button-upload<?php echo $option['product_option_id'] . $pr; ?>"
                                                        data-loading-text="<?php echo $text_loading; ?>"
                                                        class="btn btn-block btn-default"><i
                                                        class="fa fa-upload"></i> <?php echo $button_upload; ?>
                                                </button>
                                                <input type="hidden"
                                                       name="option[<?php echo $option['product_option_id']; ?>]"
                                                       value=""
                                                       id="input-option<?php echo $option['product_option_id'] . $pr; ?>"/>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'date') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label col-sm-12
                                            "
                                                   for="input-option<?php echo $option['product_option_id'] . $pr; ?>"><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <div class="input-group date">
                                                    <input type="text"
                                                           name="option[<?php echo $option['product_option_id']; ?>]"
                                                           value="<?php echo $option['value']; ?>"
                                                           data-date-format="YYYY-MM-DD"
                                                           id="input-option<?php echo $option['product_option_id'] . $pr; ?>"
                                                           class="form-control"/>
											<span class="input-group-btn">
												<button class="btn btn-default" type="button"><i
                                                        class="fa fa-calendar"></i></button>
											</span>
                                                </div>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'datetime') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label col-sm-12
                                            "
                                                   for="input-option<?php echo $option['product_option_id'] . $pr; ?>"><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <div class="input-group datetime">
                                                    <input type="text"
                                                           name="option[<?php echo $option['product_option_id']; ?>]"
                                                           value="<?php echo $option['value']; ?>"
                                                           data-date-format="YYYY-MM-DD HH:mm"
                                                           id="input-option<?php echo $option['product_option_id'] . $pr; ?>"
                                                           class="form-control"/>
									<span class="input-group-btn">
									<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i>
                                    </button>
									</span></div>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'time') { ?>
                                        <div
                                            class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label col-sm-12
                                            "
                                                   for="input-option<?php echo $option['product_option_id'] . $pr; ?>"><?php echo $option['name']; ?></label>

                                            <div class="col-sm-12">
                                                <div class="input-group time">
                                                    <input type="text"
                                                           name="option[<?php echo $option['product_option_id']; ?>]"
                                                           value="<?php echo $option['value']; ?>"
                                                           data-date-format="HH:mm"
                                                           id="input-option<?php echo $option['product_option_id'] . $pr; ?>"
                                                           class="form-control"/>
									<span class="input-group-btn">
									<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i>
                                    </button>
									</span></div>
                                            </div>
                                        </div>
                                    <?php } ?>
                                <?php } ?>
                                <button class="product-btn-add" type="button"
                                        onclick="cart.addPopup($(this),'<?php echo $product['product_id']; ?>');">
                                    <span><?php echo $button_cart; ?></span>
                                </button>
                            </div>
                        </div>
                    </div>
                <?php } ?>
			<div class="image">
				<a class="lazy" style="padding-bottom: <?php echo ($product['img-height']/$product['img-width']*100); ?>%" href="<?php echo $product['href']; ?>"><img alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" data-src="<?php echo $product['thumb']; ?>" src="#"/>
				</a>
			</div>
			  <div class="caption">
				
				<div class="rating">
				  <?php for ($i = 1; $i <= 5; $i++) { ?>
				  <?php if ($product['rating'] < $i) { ?>
						  <span class="fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
				  <?php } else { ?>
						  <span class="fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
				  <?php } ?>
				  <?php } ?>
				</div>
				
				<div class="name name-product"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
				
				<div class="description"><?php echo $product['description']; ?></div>
				<div class="description-small"><?php echo mb_substr($product['description'],0,42,'UTF-8').'...'; ?></div>
				
				<?php if ($product['price']) { ?>
                    <div class="price price-product">
                        <!-- amberu price per unit -->
                        <?php if ($product['units_in_product'] > 1) { ?>
                            <div class="price-per-unit-container">
                                <span class="price-per-unit-prefix"><?php echo $text_price_per_unit; ?></span>
                                <span class=" <?php echo $product['special'] ? "price-per-unit-new" : "price-per-unit" ?>"> <?php echo $product['price_per_unit']; ?></span>
                            </div>
                        <?php } ?>
						<div class="price-per-product-container">
							<?php if (!$product['special']) { ?>
								<?php echo $product['price']; ?>
							<?php } else { ?>
								<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
							<?php } ?>
						</div>
                        <?php if ($product['tax']) { ?>
                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                        <?php } ?>
                    </div>
                <?php } ?>
				
				<button class="product-btn" type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart-o"></i></button>				
				
				<div class="cart-button">
					<button class="product-btn amberu-compare-btn" type="button" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="material-design-shuffle24"></i><span><?php echo $button_compare; ?></span></button>
                    <div class="amberu-counter-container">
						<a class="counter counter-minus material-design-horizontal39" href='#'></a>
						<input type="text" name="quantity-counter" value="1" size="1" class="form-control cart-q" id="cart-q"/>
						<a class="counter counter-plus material-design-add186" href='#'></a>
					</div>
					<button class="product-btn-add" type="button" onclick="ajaxAdd($(this),<?php echo $product['product_id'] ?>);"><?php echo $button_cart; ?></button>					
                </div>

				</div>
				
                <div class="aside">
					<?php if ($product['price']) { ?>
						<div class="price price-product">
                            <!-- amberu price per unit -->
                            <?php if ($product['units_in_product'] > 1) { ?>
                                <div class="price-per-unit-container">
                                    <span class="price-per-unit-prefix"><?php echo $text_price_per_unit; ?></span>
                                    <span class=" <?php echo $product['special'] ? "price-per-unit-new" : "price-per-unit" ?>"> <?php echo $product['price_per_unit']; ?></span>
                                </div>
                            <?php } ?>
							<div class="price-per-product-container">
								<?php if (!$product['special']) { ?>
									<?php echo $product['price']; ?>
								<?php } else { ?>
									<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
								<?php } ?>
							</div>
							<?php if ($product['tax']) { ?>
								<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
							<?php } ?>
						</div>
					<?php } ?>
					<div class="cart-button">
						<button class="product-btn amberu-compare-btn" type="button"  title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="material-design-shuffle24"></i> <span><?php echo $button_compare; ?></span></button>
						<div class="amberu-counter-container">
							<a class="counter counter-minus material-design-horizontal39" href='#'></a>
							<input type="text" name="quantity-counter" value="1" size="1" class="form-control cart-q" id="cart-q"/>
							<a class="counter counter-plus material-design-add186" href='#'></a>
						</div>
						<button class="product-btn-add" type="button" onclick="ajaxAdd($(this),<?php echo $product['product_id'] ?>);"><?php echo $button_cart; ?></button>
					</div>
				</div>
			</div>							
				
				<?php $i=0;
				$arr_last = $product['last_array'];
				foreach( $arr_last as $value ){
					if ($product['product_id']==$value) { $i=1; ?>
						<span class="new_pr"><?php echo $text_new; ?></span>
						<?php
						}
					}
				?>
				<?php if ($product['special'] and $i==0 ) { ?>
						<span class="sale"><?php echo $text_sale; ?></span>
				<?php } ?>
				
            </div>
		</div>
		<?php } ?>
	  </div>
	  <div class="row">
		<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
		<div class="col-sm-6 text-right"><div class="results"><?php echo $results; ?></div></div>

	  </div>
	  <?php } ?>
	  <?php if (!$categories && !$products) { ?>
	  <p><?php echo $text_empty; ?></p>
	  <div class="buttons">
		<div class="pull-right"><a href="<?php echo $continue; ?>" class="btn"><?php echo $button_continue; ?></a></div>
	  </div>
	  <?php } ?>
	  <?php echo $content_bottom; ?></div>
	<?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>