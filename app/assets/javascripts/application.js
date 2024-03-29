// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require isotope.min
//= require chosen.min
//= require users
//= require posts
//= require inboxes/discussions
//= require timeago
//= require hovercard.min

$(function() {
	//$(".notice, .alert").fadeOut(10000);
	
	//Chosen
	$(".chzn-select").chosen();
	$(".chzn-select-optional").chosen({allow_single_deselect: true});
	
	$(".hoverme").hovercard({ showFacebookCard: true, facebookUserName: true });
});