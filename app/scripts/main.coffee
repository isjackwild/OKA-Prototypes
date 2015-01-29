console.log "'Allo from CoffeeScript!"

imageFilenames = [
	'landscape-1.jpg',
	'landscape-2.jpg',
	'portrait-1.jpg',
	'portrait-2.jpg',
	'widescreen-1.jpg',
	'square-1.jpg'
]

$('.left-context').on 'mouseenter', ->
	$('body').addClass 'mouseover-menu'

$('.left-context').on 'mouseleave', ->
	$('body').removeClass 'mouseover-menu'


$('.tile-inner-wrap').on 'click', (e) ->
	$target = $(e.currentTarget)

	$.ajax
		url: "project-template.html"
	.done (data) ->
		onContentLoad $target, data


$('.image-wrap').on 'click', (e)->
	x = Math.floor Math.random()*imageFilenames.length
	newSrc = 'images/' + imageFilenames[x]
	console.log newSrc, $(e.currentTarget).find('img')
	$(e.currentTarget).find('img')[0].src = newSrc
	if newSrc.indexOf('portrait') >= 0
		$(e.currentTarget).addClass 'portrait'
	else
		$(e.currentTarget).removeClass 'portrait'



onContentLoad = ($target, data) ->
	x = $target.offset().left;
	y = $target.offset().top;
	w = $target.width();
	h = $target.height()


	newPageContext = document.createElement 'div'
	newPageContext.className = 'page-context mini incoming project'
	newPageContext.style.left = x+'px'
	newPageContext.style.top = y+'px'
	newPageContext.style.width = w+'px'
	newPageContext.style.height = h+'px'

	$('.page-context-wrap').append newPageContext

	setTimeout ->
		$('.page-context.incoming').attr 'style', ''
	,50

	setTimeout ->
		$('.page-context.incoming').removeClass 'mini incoming'
		$('.page-context.outgoing').remove()
		$('.page-context').addClass 'outgoing'
		$('.page-context').prepend data
		newPageContext = undefined
	,444