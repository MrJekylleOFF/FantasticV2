$(function(){
	boreDOM.init();
	boreDOM.spaceBackground.init();
});

var boreDOM = {

	upgrade: 'one-canon',

	count: {
		number: 0
	},

	ship: {
		shipId: '#ship',
		bullet: '<div class="bullet">',
		shipSpeed: 5,
		bulletSpeed: 2000
	},

	enemy: {
		small: {
			divClass: 'enemy-1',
			bulletClass: '.enemy-bullet',
			bulletSpeed: 8000,
			speed: 40000, 
			frequency: 1500
		}
	},

	init: function() {
		this.bindShip();
		this.bindWeapon();
		this.displayCount();
		this.drawEnemy();		
	},	

	bindShip: function(){
		var area = $('body'),
		    ship = $(this.ship.shipId),
		    speed = this.ship.shipSpeed,
		    maxValue = area.width() - ship.width() + 100,
		    keysPressed = {},
		    distancePerIteration = speed;

		function calculateNewValue(oldValue, keyCode1, keyCode2) {
		    var newValue = parseInt(oldValue, 10)
		                   - (keysPressed[keyCode1] ? distancePerIteration : 0)
		                   + (keysPressed[keyCode2] ? distancePerIteration : 0);
		    return newValue < 0 ? 0 : newValue > maxValue ? maxValue : newValue;
		}

		$(window).keydown(function(event) { 
			if(event.which == 37) {
				$('#ship').css({'background-position':'left'});				
			}	
			if(event.which == 39) {
				$('#ship').css({'background-position':'right'});				
			}

			keysPressed[event.which] = true; 

		});
		$(window).keyup(function(event) { 
			if(event.which == 37 ||event.which == 39 ) {
				$('#ship').css({'background-position':'center'});				
			}	
			keysPressed[event.which] = false; 
		});

		setInterval(function() {			
		    ship.css({
		        left: function(index ,oldValue) {
		            return calculateNewValue(oldValue, 37, 39);
		        },
		        top: function(index, oldValue) {
		            return calculateNewValue(oldValue, 38, 40);
		        }
		    });
		}, 20);
	},

	bindWeapon: function(){
		var bullet = this.ship.bullet,
			bulletSpeed = this.ship.bulletSpeed,
			ship = this.ship.shipId,
			fired = false;

		$(window).keydown(function(event){

			
			// Fire on space down
			if(event.which == 32 && fired == false){	

				switch(boreDOM.upgrade){
				case 'one-canon':
				  	$(bullet).appendTo('body').each(function() {
						var bullet = $(this);
						var shipOffset = $(ship).offset();
						bullet.css({'left':shipOffset.left + 54, 'top':shipOffset.top - 15});					
					  
					    animateBullet(bullet);
					});
				  break;
				case 'two-canons':
				 	 $(bullet).appendTo('body').each(function() {
						var bullet = $(this);
						var shipOffset = $(ship).offset();
						bullet.css({'left':shipOffset.left + 26, 'top':shipOffset.top + 25});					
					  
					    animateBullet(bullet);
					});
				 	 $(bullet).appendTo('body').each(function() {
						var bullet = $(this);
						var shipOffset = $(ship).offset();
						bullet.css({'left':shipOffset.left + 84, 'top':shipOffset.top + 25});					
					  
					    animateBullet(bullet);
					});
				  break;
				}
				fired = true;
			}
		});

		$(window).keyup(function(event){if(event.which == 32){fired = false;}}); // Recharger le canon lors de la pression de touche



		function animateBullet(bullet){
			if($('.enemy-1').length > 0){ // Verification collision uniquement s'il y a un navire ennemi	
		    	bullet.animate({ top: '-3000px'}, {
		            duration: bulletSpeed,
		            step    : function() {

		            		$('.enemy-1').each(function(){

				    			var enemy  = $(this);
							    var enemySize = {
							        height: 50,
							        width : 50
							    };	

							    var bulletSize = {
							        height: 10,
							        width : 3
							    };

				                if (boreDOM.testCollision(bullet.position(), bulletSize, enemy.position(), enemySize, enemy)){	

				                	if(enemy.position().top + 25 > 0){ // Assurez-vous que l'objet est visible
				                		bullet.stop();
				                		bullet.remove();

				                		boreDOM.count.number = boreDOM.count.number + 100;  
										$('#count').text(boreDOM.count.number);

										// Améliorer l'arme
										if(boreDOM.count.number == 2000){
											$('#ship').css({'background-image':'url(https://i.imgur.com/fu4owJH.png)'});
											boreDOM.upgrade = 'two-canons';
										}

										boreDOM.triggerExplosion(enemy.position().top - enemySize.height, enemy.position().left - enemySize.width);
								    	setTimeout(function(){
									        enemy.remove();
									    }, 100);
								        return true;
									} 
				                }	

		                	});	
		            },
		            queue   : false,
		            complete: function(){bullet.remove();}
		        });
		    } else {
		    	bullet.animate({ top: '-3000px'}, bulletSpeed);
		    }
		}
	},

	testCollision: function(position1, size1, position2, size2, target, playerShip){	
		var correction = 0;
		if(playerShip){correction = 50}

		if (((position1.left + size1.width)  > position2.left - correction) &&
	        ((position1.top  + size1.height) > position2.top + correction)  &&
	        ((position2.left - correction + size2.width)  > position1.left) &&
	        ((position2.top + correction  + size2.height) > position1.top)) {
			return true;
	    }
	},

	triggerExplosion: function(topPosition, lefPosition, playerShip){

		var explosionClass = 'explode';

		if(playerShip){
			//explosionClass = 'palyerExplode';
		}

		$('<div class="'+explosionClass+'"><img src="http://andreypokrovskiy.com/image_hosting/boredom/explosion.gif"></div>').appendTo('body').each(function(){
			var explosion = $(this);
			explosion.css({left: lefPosition + 50, top: topPosition});

			setTimeout(function(){				
				explosion.remove();
			}, 1700);
		});
	},
	

	drawEnemy: function(){
		var enemyClass = this.enemy.small.divClass,
			speed = this.enemy.small.speed,
			frequency = this.enemy.small.frequency,
  			enemyPos,
  			enemyShip;

  		var enemyInterval;	
  		var levelUp = true;

  		var ship = $("#ship");		

		enemyInterval = setInterval(function(){
			$('<div class="'+enemyClass+'">').appendTo('body').each(function(){	
				var enemyShip = $(this),
					shootingInt = false;	

				enemyShip.css({'left': Math.random()*100+'%'}); // Positionner aléatoirement le navire ennemi


				enemyShip.animate({'top':50, 'left':Math.random()*100+'%'}, { duration: 250, // Navire ennemi "Warp in"					

					complete: function(){

						enemyShip.animate({'top':'110%', 'left':Math.random()*100+'%'}, {
				            duration: speed,
				            step: function() {
				            	if(ship.length > 0){
					            	var shipPos = ship.position().left;
					            	enemyPos = Math.round(enemyShip.position().left);

				            	  	if((shipPos - 150) < enemyPos && enemyPos < (shipPos + 150)){	
					                	if (!shootingInt) {
					              	 		shootingInt = setInterval(function(){
					                			enemyShoot(ship, enemyShip);
					                		}, 800);	
					                	}               		
					                } else {
					               		clearInterval(shootingInt);
					               		shootingInt = false;
					               }
				               }
				            },
				            queue   : false,
				            complete: function(){								
								$(this).remove(); 
				            }
				        });	
		            }
				});
			});
			

			
		},frequency);	
		
		setInterval(function(){
			if(boreDOM.count.number == 1000 && levelUp == true){
				levelUp = false;
				frequency = frequency - 500
				clearInterval(enemyInterval);

				enemyInterval = setInterval(function(){
					$('<div class="'+enemyClass+'">').appendTo('body').each(function(){	
						var enemyShip = $(this),
							shootingInt = false;	

						enemyShip.css({'left': Math.random()*100+'%'}); // Positionner aléatoirement le navire ennemi


						enemyShip.animate({'top':50, 'left':Math.random()*100+'%'}, { duration: 250, // Navire ennemi "Warp in"					

							complete: function(){

								enemyShip.animate({'top':'110%', 'left':Math.random()*100+'%'}, {
						            duration: speed,
						            step: function() {
						            	if(ship.length > 0){
							            	var shipPos = ship.position().left;
							            	enemyPos = Math.round(enemyShip.position().left);

						            	  	if((shipPos - 150) < enemyPos && enemyPos < (shipPos + 150)){	
							                	if (!shootingInt) {
							              	 		shootingInt = setInterval(function(){
							                			enemyShoot(ship, enemyShip);
							                		}, 800);	
							                	}               		
							                } else {
							               		clearInterval(shootingInt);
							               		shootingInt = false;
							               }
						               }
						            },
						            queue   : false,
						            complete: function(){								
										$(this).remove(); 
						            }
						        });	
				            }
						});
					});					
				},frequency);
			}		
		},100);
		
		


		function enemyShoot(ship, enemyShip){
  	 			
			$('<div class="enemy-bullet">').appendTo('body').each(function() {
				var bullet = $(this);
				var shipOffset = enemyShip.offset();

				var ballSize = {
			        height: $(this).height(),
			        width : $(this).width()
			    };

			   
			    var shipSize = {
			        height: ship.height(),
			        width : ship.width()
			    };

				bullet.css({'left':shipOffset.left + 22, 'top':shipOffset.top + 45});


				bullet.animate({ top: '1000%'}, {
		            duration: 12000, 
		            step    : function() {

		            	if (boreDOM.testCollision(bullet.position(), ballSize, ship.position(), shipSize, ship, true)){					   					
		   					bullet.stop();
		                	bullet.remove();
		                	boreDOM.triggerExplosion(ship.position().top, ship.position().left - shipSize.width, true);
		                	boreDOM.decreaseLife();
		                } 

		                var topPos = bullet.css('top');
		           		if(topPos > 1200){
		           			bullet.stop();
		            		bullet.remove();
		           		}	

		            },
		            queue   : false,
		            complete: function(){bullet.remove();}
		        });

			});

		}		
	},

	decreaseLife: function() {
		$('.life-bar .inside-bar').css({'height': $('.life-bar .inside-bar').height() - 50});		                	
    	if($('.life-bar .inside-bar').height() <= 0 ){
    		// Recharge la page actuelle, sans utiliser le cache
			document.location.reload(true);
    	}
	},

	displayCount: function() {
		$('body').append('<div id="count">'+this.count.number+'</div>');
	}
};

/*
	Dessiner des éléments d'arrière-plan de l'espace
=========================================================*/
!(function($) {

	$.extend(boreDOM,{

	  	spaceBackground: {

	  		stars: {
				
				asteroid: [{
					div: '<div class="asteroid">',
					speed: 10000, 
					frequency: 20000 
				}],

				planet: [{
					div: '<div class="planet">',
					speed: 60000, 
					frequency: 40000 
				}],

				hugePlanet: [{
					div: '<div class="huge-planet">',
					speed: 40000, 		
					frequency: 60000 
				}],

				expPlanet: [{
					div: '<div class="exp-planet">',
					speed: 60000, 		
					frequency: 80000 
				}],

				moon: [{
					div: '<div class="moon">',
					speed: 20000, 
					frequency: 100000 
				}]
			},			

			init: function(){				
				this.drawSpaceBackground();				
			},

			drawSpaceBackground: function(){
				var stars = this.stars;	

				$.each(stars, function(star, items){
					$.each(items, function(idx, star){				      

				        window.setInterval(function(){
							$(star.div).appendTo('body').each(function() {	
								$(this).css({'left': Math.random()*100+'%'});
								$(this).animate({'top':'110%'}, star.speed).promise().done( function() {  $(this).remove(); });
							});
						}, star.frequency);
				      
				    });
				});		
			}
	  	}
	});

})($);