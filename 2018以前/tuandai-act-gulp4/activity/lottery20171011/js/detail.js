(function() {
	FastClick.attach(document.body);
	var swiper = new Swiper('.swiper-container-1', {
		pagination: '.swiper-pagination-1',
		paginationClickable: true,
		autoplay:2000
	});


	var rem = 20 *($(window).width() / 320) ;

	var stre_n = -50/23.4375/2*rem,
		depth_n =200/23.4375/2*rem,
		modifier_1 = 1/23.4375/2*rem;

	var swiper = new Swiper('.swiper-container-2', {
		pagination: '.swiper-pagination-2',
		effect: 'coverflow',
		grabCursor: true,
		centeredSlides: true,
		slidesPerView: 'auto',
			loop : true,

		coverflow: {
			rotate: 0,
			stretch:stre_n,
			depth: depth_n,
			modifier:1,
		}
	});
})();