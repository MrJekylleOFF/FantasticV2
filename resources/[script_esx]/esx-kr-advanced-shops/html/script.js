
$(function() {
		window.addEventListener('message', function(event) {

			if (event.data.type == 'shop') {
				$('#wrapper').show("fast");
				$('.banner').append(`<img src="${event.data.info.ShopLogo}"><h1>${event.data.info.ShopName}</h1>`)
			var i1;
			var id = 750;

			/*if (event.data.result.length > 10) {
				for (i1 = 0; i1 < (event.data.result.length -10) / 5; i1++) { 
					
					$('#wrapper').append(
						`<div class="line" style = "top: ${id}px; position: relative;"></div>`
					);

					id = id + 375
				}
			}*/

			var i;
			
			for (i = 0; i < event.data.result.length; i++) {
		
				$('#list-items').append(
					`<div class = "image item-${event.data.result[i].categorie} item-all" id = ${event.data.result[i].item} img = ${event.data.result[i].src} label = ${event.data.result[i].label} count = ${event.data.result[i].count} price = ${event.data.result[i].price}>
						<div class="item-content">
							<div class="illu">
								<img src="${event.data.result[i].src}"/>
							</div>
							<div class="details">
								<p class="item-label">${event.data.result[i].label}</p>
								<p class="item-stock">Stock : ${event.data.result[i].count}</p>
							</div>
						</div>
						<div class = "add-panier"><span>${event.data.result[i].price}$</span><span>Ajouter au panier</span></div>
					</div>`
				);
			}

			if (event.data.owner == true) {

				$('#wrapper').append(
					` 
					<button id = "bossactions" class="green" style = "position: absolute; right: 25px; top: 25px;">Gestion Entreprise</button>
					`
				);
			}

			var CartCount = 0;

			$('body').on('click', '.image', function () {
				$("#cart").load(location.href + " #cart");

				$('.carticon').show("fast");

				CartCount = CartCount + 1;
				var item = $(this).attr('id');
				var img = $(this).attr('img');
				var label = $(this).attr('label');
				var count = $(this).attr('count');
				var price = $(this).attr('price');

				$('.cartcount').show("fast");
				$('.cartcount').html('');
				$('.cartcount').append('<span style="color:white;">'+CartCount+'</span>');

				$("#" + item).hide();
				

				$.post('http://esx-kr-advanced-shops/putcart', JSON.stringify({item: item, img: img, price : price, label : label, count : count, id : id}), function( cb ) {

					$('#cart').html('');

					var i;
					var total_base = 0;

					for (i = 0; i < cb.length; i++) { 

						total_base += parseInt(cb[i].price);

						$('#cart').append(
							`<div class = "cartitem" label = ${cb[i].label} count = ${cb[i].count} price = ${cb[i].price}>
								<img src="${cb[i].img}">
								<h6>${cb[i].label}</h6>
								<h6 class="total-item">$<span>${cb[i].price}</span></h4>
								<h6>En stock: ${cb[i].count}</h4>
								<div class="quantity">
									<input type="number" price = ${cb[i].price} id = ${cb[i].item} count = ${cb[i].count} min="1" max = ${cb[i].count} class = "textareas" placeholder = "Quantite" value="1" readonly>
									<div class="quantity-nav"><div class="quantity-button quantity-up">+</div><div class="quantity-button quantity-down">-</div></div>
								</div>
								<button class="item-delete" id = ${cb[i].item}>x</button>
							</div>`
								);
							};

							$('#cart').append(
							`
							<button class = "green" id = "buybutton"><i class="fa fa-shopping-cart" aria-hidden="true"></i>
Acheter - Total : <span class="grand-total">${total_base}</span>$</button>
							<button id = "back" style = "position: absolute; width:250px; height:35px; left:15px; top:15px;"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i>
Retour</button>
							`
						);
					});
			});
			
			$('.carticon').on('click', function () {
				$('#cart').show("fast");
				$('#wrapper').hide("fast");
				$('.carticon').hide("fast");
			});

			$("body").on("click", "#refreshcart", function() {
				$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
				location.reload(true);
				$('#wrapper').hide("fast");
				$('#payment').hide("fast");
				$('#cart').hide("fast");
				$.post('http://esx-kr-advanced-shops/refresh', JSON.stringify({}));
			});

			$("body").on("click", ".item-delete", function() {
				var item = $(this).attr('id');
				$.post('http://esx-kr-advanced-shops/removecart', JSON.stringify({item:item}), function(cb){
					$('#cart').html('');

					var i;
					var total_base = 0;

					if( cb.length < 1 )
					{
						$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
						location.reload(true);
						$('#cart').hide();
						$('#wrapper').html('').show();
						$('.carticon').html('').hide();
						$.post('http://esx-kr-advanced-shops/refresh', JSON.stringify({}));
					}
					else
					{
						for (i = 0; i < cb.length; i++) { 

							total_base += parseInt(cb[i].price);

							$('#cart').append(
								`<div class = "cartitem" label = ${cb[i].label} count = ${cb[i].count} price = ${cb[i].price}>
									<img src="${cb[i].img}">
									<h6>${cb[i].label}</h6>
									<h6 class="total-item">$<span>${cb[i].price}</span></h4>
									<h6>En stock: ${cb[i].count}</h4>
									<div class="quantity">
										<input type="number" price = ${cb[i].price} id = ${cb[i].item} count = ${cb[i].count} min="1" max = ${cb[i].count} class = "textareas" placeholder = "Quantite" value="1" readonly>
										<div class="quantity-nav"><div class="quantity-button quantity-up">+</div><div class="quantity-button quantity-down">-</div></div>
									</div>
									<button class="item-delete" id = ${cb[i].item}>x</button>
								</div>`
									);
								};

								$('#cart').append(
								`
								<button class = "green" id = "buybutton"><i class="fa fa-shopping-cart" aria-hidden="true"></i>
	Acheter - Total : <span class="grand-total">${total_base}</span>$</button>
								<button id = "back" style = "position: absolute; width:250px; height:35px; left:15px; top:15px;"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i>
	Retour</button>
								`
							);
					}
				});
			});

			$("body").on("click", "#back", function() {
				$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
				location.reload(true);
				$('#cart').hide();
				$('#wrapper').html('').show();
				$('.carticon').html('').hide();
				$.post('http://esx-kr-advanced-shops/refresh', JSON.stringify({}));
			});

			$("body").on('click', '.btn-filtre', function()
			{
				var type = $(this).data('type');
				$('.image').hide();
				$('.item-'+type).show();
			})

			$("body").on("click", "#buybutton", function() {
				var value = document.getElementsByClassName("textareas");

				for (i = 0; i < value.length; i++) {

					var isNumber = isNaN(value[i].value) === false;

					var count = $('#' + value[i].id).attr('count');

					if (parseInt(count) >= parseInt(value[i].value) && parseInt(value[i].value) != 0 && isNumber) {

						$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
					
						location.reload(true);

						$('#wrapper').hide("fast");
						$('#payment').hide("fast");
						$('#cart').hide("fast");
						$.post('http://esx-kr-advanced-shops/buy', JSON.stringify({Count : value[i].value, Item : value[i].id}));
					} 
					else {
						$.post('http://esx-kr-advanced-shops/notify', JSON.stringify({msg : "~r~Un des article n\'a pas assez de stock ou est invalide."}));
					}
				}
			});


			      $('body').on('click', '.quantity-up', function() {

			  		var spinner = $(this).parent().parent();
			      	var input = spinner.find('input[type="number"]');
			      	var price = input.attr('price');
			      	var min = input.attr('min');
			      	var max = input.attr('max');
			        var oldValue = parseFloat(input.val());
			        if (oldValue >= max) {
			          var newVal = oldValue;
			        } else {
			          var newVal = oldValue + 1;
			        }
			        var total_item = newVal * price;			        
			      	$(this).parent().parent().parent().find('.total-item span').html(total_item);
			        spinner.find("input").val(newVal);
			        spinner.find("input").trigger("change");

			        var total_base = 0;
			        $('.total-item span').each(function()
			        {
			        	total_base += parseInt( $(this).html() );
			        });

			        $('.grand-total').html(total_base);

			      });

			      $('body').on('click', '.quantity-down', function() {
			      	var spinner = $(this).parent().parent();
			      	var input = spinner.find('input[type="number"]');
			      	var price = input.attr('price');
			      	var min = input.attr('min');
			      	var max = input.attr('max');
			        var oldValue = parseFloat(input.val());
			        if (oldValue <= min) {
			          var newVal = oldValue;
			        } else {
			          var newVal = oldValue - 1;
			        }
			        var total_item = newVal * price;
			      	$(this).parent().parent().parent().find('.total-item span').html(total_item);
			        spinner.find("input").val(newVal);
			        spinner.find("input").trigger("change");

			        var total_base = 0;
			        $('.total-item span').each(function()
			        {
			        	total_base += parseInt( $(this).html() );
			        });

			        $('.grand-total').html(total_base);
			      });

			
			$("body").on("click", "#bossactions", function() {
				$.post('http://esx-kr-advanced-shops/bossactions', JSON.stringify({}));
				$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
				location.reload(true);
				$.post('http://esx-kr-advanced-shops/emptycart', JSON.stringify({}));
				$('#wrapper').hide("fast");
				$('#payment').hide("fast");
				$('#cart').hide("fast");
			});
		}
	});

	


	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
			location.reload(true);
			$.post('http://esx-kr-advanced-shops/emptycart', JSON.stringify({}));
			$('#wrapper').hide("fast");
			$('#payment').hide("fast");
			$('#cart').hide("fast");
		}
	}
});
