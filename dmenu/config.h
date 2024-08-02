/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Mononoki Nerd Font:size=10:antialias=true:autohint=true"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

/* Equilux colors */
static const char col_gray1[] = "#2E2E2E"; /* Background color */
static const char col_gray2[] = "#444444"; /* Border color */
static const char col_gray3[] = "#E6E6E6"; /* Foreground color */
static const char col_gray4[] = "#FFFFFF"; /* Selected foreground color */
static const char col_cyan[]  = "#444444"; /* Selected background color */

static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { col_gray3, col_gray1 },
	[SchemeSel]  = { col_gray4, col_cyan },
	[SchemeOut]  = { col_gray3, col_gray1 },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
