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


# $('.tile-inner-wrap').on 'click', (e) ->
# 	$target = $(e.currentTarget)

# 	$.ajax
# 		url: "project-template.html"
# 	.done (data) ->
# 		onContentLoad $target, data


$('.image-wrap').on 'click', (e)->
	x = Math.floor Math.random()*imageFilenames.length
	newSrc = 'images/' + imageFilenames[x]
	$(e.currentTarget).find('img')[0].src = newSrc
	if newSrc.indexOf('portrait') >= 0
		$(e.currentTarget).addClass 'portrait'
	else
		$(e.currentTarget).removeClass 'portrait'



$('a.history-link').on 'click', (e) ->
	$target = $($(e.currentTarget).children()[0])
	e.preventDefault();

	$.ajax
		url: e.currentTarget.href
	.done (data) ->
		onContentLoad $target, data
		history.pushState(null, null, e.currentTarget.href);


$(window).on 'popstate', (e) ->
	console.log location.pathname
	$.ajax
		url: location.pathname
	.done (data) ->
		onContentLoad null, data


onContentLoad = ($target, data) ->
	console.log 'on content loaded'
	if $target
		x = $target.offset().left - 40;
		y = $target.offset().top;
		w = $target.width();
		h = $target.height()


	newPageContext = document.createElement 'div'
	newPageContext.className = 'page-context mini incoming project'

	if $target
		newPageContext.style.clip = 'rect(+'+y+'px,'+(x+w)+'px,'+(y+h)+'px,'+x+'px)'

	$('.page-context-wrap').append newPageContext
	$('.page-context.incoming').prepend data
	setTimeout ->
		$('.page-context.incoming').attr 'style', ''
	,10

	setTimeout ->
		$('.page-context.incoming').removeClass 'mini incoming'
		$('.page-context.outgoing').remove()
		$('.page-context').addClass 'outgoing'
		newPageContext = undefined
	,4444