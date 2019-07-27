---
layout: post
title: Scattertext
---



<!-- some code adapted from www.degeneratestate.org/static/metal_lyrics/metal_line.html -->
<!-- <!DOCTYPE html>
<meta content="utf-8"> -->
<style> /* set the CSS */

body {
  font: 12px Arial;
}

svg {
  font: 12px Helvetica;
}

path {
  stroke: steelblue;
  stroke-width: 2;
  fill: none;
}

.grid line {
  stroke: lightgrey;
  stroke-opacity: 0.4;
  shape-rendering: crispEdges;
}

.grid path {
  stroke-width: 0;
}

.axis path,
.axis lineper {
  fill: none;
  stroke: grey;
  stroke-width: 1;
  shape-rendering: crispEdges;
}

div.tooltip {
  position: absolute;
  text-align: center;
  width: 150px;
  height: 28px;
  padding: 2px;
  font: 12px sans-serif;
  background: lightsteelblue;
  border: 0px;
  border-radius: 8px;
  pointer-events: none;
}

div.tooltipscore {
  position: absolute;
  text-align: center;
  width: 150px;
  height: 50px;
  padding: 2px;
  font: 10px sans-serif;
  background: lightsteelblue;
  border: 0px;
  border-radius: 8px;
  pointer-events: none;
}

.category_header {
  font: 12px sans-serif;
  font-weight: bolder;
  text-decoration: underline;
}

div.label {
  color: rgb(252, 251, 253);
  color: rgb(63, 0, 125);
  color: rgb(158, 155, 201);

  position: absolute;
  text-align: left;
  padding: 1px;
  border-spacing: 1px;
  font: 10px sans-serif;
  font-family: Sans-Serif;
  border: 0;
  pointer-events: none;
}

input {
  border: 1px dotted #ccc;
  background: white;
  font-family: monospace;
  padding: 10px 20px;
  font-size: 14px;
  margin: 20px 10px 30px 0;
  color: darkred;
}

.alert {
  font-family: monospace;
  padding: 10px 20px;
  font-size: 14px;
  margin: 20px 10px 30px 0;
  color: darkred;
}

ul.top_terms li {
  padding-right: 20px;
  font-size: 30pt;
  color: red;
}

input:focus {
  background-color: lightyellow;
  outline: none;
}

.snippet {
  padding-bottom: 10px;
  padding-left: 5px;
  padding-right: 5px;
  white-space: pre-wrap;
}

.snippet_header {
  font-size: 20px;
  font-family: Helvetica, Arial, Sans-Serif;
  font-weight: bolder;
  #text-decoration: underline;
  text-align: center;
  border-bottom-width: 10px;
  border-bottom-color: #888888;
  padding-bottom: 10px;
}

.topic_preview {
  font-size: 12px;
  font-family: Helvetica, Arial, Sans-Serif;
  text-align: center;
  padding-bottom: 10px;
  font-weight: normal;
  text-decoration: none;
}


#d3-div-1-categoryinfo {
  font-size: 12px;
  font-family: Helvetica, Arial, Sans-Serif;
  text-align: center;
  padding-bottom: 10px;    

}


#d3-div-1-title-div {
  font-size: 20px;
  font-family: Helvetica, Arial, Sans-Serif;
  text-align: center;
}

.text_header {
  font: 18px sans-serif;
  font-size: 18px;
  font-family: Helvetica, Arial, Sans-Serif;

  font-weight: bolder;
  text-decoration: underline;
  text-align: center;
  color: darkblue;
  padding-bottom: 10px;
}

.text_subheader {
  font-size: 14px;
  font-family: Helvetica, Arial, Sans-Serif;

  text-align: center;
}

.snippet_meta {
  border-top: 3px solid #4588ba;
  font-size: 12px;
  font-family: Helvetica, Arial, Sans-Serif;
  color: darkblue;
}

.not_match {
    background-color: #F0F8FF;
}
    
.contexts {
  width: 45%;
  float: left;
}

.neut_display {
  display: none;
  float: left
}

.scattertext {
  font-size: 10px;
  font-family: Helvetica, Arial, Sans-Serif;
}

.label {
  font-size: 10px;
  font-family: Helvetica, Arial, Sans-Serif;
}

.obscured {
  /*font-size: 14px;
  font-weight: normal;
  color: dimgrey;
  font-family: Helvetica;*/
  text-align: center;
}

.small_label {
  font-size: 10px;
}

#d3-div-1-corpus-stats {
  text-align: center;
}

#d3-div-1-cat {
}

#d3-div-1-notcat {
}

#d3-div-1-neut {
}

#d3-div-1-neutcol {
  display: none;
}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.6.0/d3.min.js" charset="utf-8"></script>
<script src="https://d3js.org/d3-scale-chromatic.v1.min.js" charset="utf-8"></script>

<!-- INSERT SEMIOTIC SQUARE -->
<!--<a onclick="maxFreq = Math.log(data.map(d => d.cat + d.ncat).reduce((a,b) => Math.max(a,b))); plotInterface.redrawPoints(0.1, d => (Math.log(d.ncat + d.cat)/maxFreq), d => d.s, false); plotInterface.redrawPoints(0.1, d => (Math.log(d.ncat + d.cat)/maxFreq), d => d.s, true)">View Score Plot</a>-->
<span id="d3-div-1-title-div"></span>
<div class="scattertext" id="d3-div-1"></div>
<div id="d3-div-1-corpus-stats"></div>
<div id="d3-div-1-overlapped-terms"></div>
<form name="d3-div-1-termForm" onSubmit="plotInterface.handleSearch(); return false;">
  <input name="Submit" type="submit" value="Search for term">
  <input type="text" id="d3-div-1-searchTerm" placeholder="Type a word or two&hellip;">
  <span id="d3-div-1-alertMessage" class="alert"></span>
</form>
<a name="d3-div-1-snippets"></a>
<a name="d3-div-1-snippetsalt"></a>
<div id="d3-div-1-termstats"></div>
<div id="d3-div-1-overlapped-terms-clicked"></div>
<div id="d3-div-1-categoryinfo" style="display: hidden"></div>
<div id="d3-div-2">
  <div class="d3-div-1-contexts">
    <div class="snippet_header" id="d3-div-1-cathead"></div>
    <div class="snippet" id="d3-div-1-cat"></div>
  </div>
  <div id="d3-div-1-notcol" class="d3-div-1-contexts">
    <div class="snippet_header" id="d3-div-1-notcathead"></div>
    <div class="snippet" id="d3-div-1-notcat"></div>
  </div>
  <div id="d3-div-1-neutcol" class="d3-div-1-contexts">
    <div class="snippet_header" id="d3-div-1-neuthead"></div>
    <div class="snippet" id="d3-div-1-neut"></div>
  </div>
</div>
<script charset="utf-8">
    // Created using Cozy: github.com/uwplse/cozy
function Rectangle(ax1, ay1, ax2, ay2) {
    this.ax1 = ax1;
    this.ay1 = ay1;
    this.ax2 = ax2;
    this.ay2 = ay2;
    this._left7 = undefined;
    this._right8 = undefined;
    this._parent9 = undefined;
    this._min_ax12 = undefined;
    this._min_ay13 = undefined;
    this._max_ay24 = undefined;
    this._height10 = undefined;
}
function RectangleHolder() {
    this.my_size = 0;
    (this)._root1 = null;
}
RectangleHolder.prototype.size = function () {
    return this.my_size;
};
RectangleHolder.prototype.add = function (x) {
    ++this.my_size;
    var _idx69 = (x).ax2;
    (x)._left7 = null;
    (x)._right8 = null;
    (x)._min_ax12 = (x).ax1;
    (x)._min_ay13 = (x).ay1;
    (x)._max_ay24 = (x).ay2;
    (x)._height10 = 0;
    var _previous70 = null;
    var _current71 = (this)._root1;
    var _is_left72 = false;
    while (!((_current71) == null)) {
        _previous70 = _current71;
        if ((_idx69) < ((_current71).ax2)) {
            _current71 = (_current71)._left7;
            _is_left72 = true;
        } else {
            _current71 = (_current71)._right8;
            _is_left72 = false;
        }
    }
    if ((_previous70) == null) {
        (this)._root1 = x;
    } else {
        (x)._parent9 = _previous70;
        if (_is_left72) {
            (_previous70)._left7 = x;
        } else {
            (_previous70)._right8 = x;
        }
    }
    var _cursor73 = (x)._parent9;
    var _changed74 = true;
    while ((_changed74) && (!((_cursor73) == (null)))) {
        var _old__min_ax1275 = (_cursor73)._min_ax12;
        var _old__min_ay1376 = (_cursor73)._min_ay13;
        var _old__max_ay2477 = (_cursor73)._max_ay24;
        var _old_height78 = (_cursor73)._height10;
        /* _min_ax12 is min of ax1 */
        var _augval79 = (_cursor73).ax1;
        var _child80 = (_cursor73)._left7;
        if (!((_child80) == null)) {
            var _val81 = (_child80)._min_ax12;
            _augval79 = ((_augval79) < (_val81)) ? (_augval79) : (_val81);
        }
        var _child82 = (_cursor73)._right8;
        if (!((_child82) == null)) {
            var _val83 = (_child82)._min_ax12;
            _augval79 = ((_augval79) < (_val83)) ? (_augval79) : (_val83);
        }
        (_cursor73)._min_ax12 = _augval79;
        /* _min_ay13 is min of ay1 */
        var _augval84 = (_cursor73).ay1;
        var _child85 = (_cursor73)._left7;
        if (!((_child85) == null)) {
            var _val86 = (_child85)._min_ay13;
            _augval84 = ((_augval84) < (_val86)) ? (_augval84) : (_val86);
        }
        var _child87 = (_cursor73)._right8;
        if (!((_child87) == null)) {
            var _val88 = (_child87)._min_ay13;
            _augval84 = ((_augval84) < (_val88)) ? (_augval84) : (_val88);
        }
        (_cursor73)._min_ay13 = _augval84;
        /* _max_ay24 is max of ay2 */
        var _augval89 = (_cursor73).ay2;
        var _child90 = (_cursor73)._left7;
        if (!((_child90) == null)) {
            var _val91 = (_child90)._max_ay24;
            _augval89 = ((_augval89) < (_val91)) ? (_val91) : (_augval89);
        }
        var _child92 = (_cursor73)._right8;
        if (!((_child92) == null)) {
            var _val93 = (_child92)._max_ay24;
            _augval89 = ((_augval89) < (_val93)) ? (_val93) : (_augval89);
        }
        (_cursor73)._max_ay24 = _augval89;
        (_cursor73)._height10 = 1 + ((((((_cursor73)._left7) == null) ? (-1) : (((_cursor73)._left7)._height10)) > ((((_cursor73)._right8) == null) ? (-1) : (((_cursor73)._right8)._height10))) ? ((((_cursor73)._left7) == null) ? (-1) : (((_cursor73)._left7)._height10)) : ((((_cursor73)._right8) == null) ? (-1) : (((_cursor73)._right8)._height10)));
        _changed74 = false;
        _changed74 = (_changed74) || (!((_old__min_ax1275) == ((_cursor73)._min_ax12)));
        _changed74 = (_changed74) || (!((_old__min_ay1376) == ((_cursor73)._min_ay13)));
        _changed74 = (_changed74) || (!((_old__max_ay2477) == ((_cursor73)._max_ay24)));
        _changed74 = (_changed74) || (!((_old_height78) == ((_cursor73)._height10)));
        _cursor73 = (_cursor73)._parent9;
    }
    /* rebalance AVL tree */
    var _cursor94 = x;
    var _imbalance95;
    while (!(((_cursor94)._parent9) == null)) {
        _cursor94 = (_cursor94)._parent9;
        (_cursor94)._height10 = 1 + ((((((_cursor94)._left7) == null) ? (-1) : (((_cursor94)._left7)._height10)) > ((((_cursor94)._right8) == null) ? (-1) : (((_cursor94)._right8)._height10))) ? ((((_cursor94)._left7) == null) ? (-1) : (((_cursor94)._left7)._height10)) : ((((_cursor94)._right8) == null) ? (-1) : (((_cursor94)._right8)._height10)));
        _imbalance95 = ((((_cursor94)._left7) == null) ? (-1) : (((_cursor94)._left7)._height10)) - ((((_cursor94)._right8) == null) ? (-1) : (((_cursor94)._right8)._height10));
        if ((_imbalance95) > (1)) {
            if ((((((_cursor94)._left7)._left7) == null) ? (-1) : ((((_cursor94)._left7)._left7)._height10)) < (((((_cursor94)._left7)._right8) == null) ? (-1) : ((((_cursor94)._left7)._right8)._height10))) {
                /* rotate ((_cursor94)._left7)._right8 */
                var _a96 = (_cursor94)._left7;
                var _b97 = (_a96)._right8;
                var _c98 = (_b97)._left7;
                /* replace _a96 with _b97 in (_a96)._parent9 */
                if (!(((_a96)._parent9) == null)) {
                    if ((((_a96)._parent9)._left7) == (_a96)) {
                        ((_a96)._parent9)._left7 = _b97;
                    } else {
                        ((_a96)._parent9)._right8 = _b97;
                    }
                }
                if (!((_b97) == null)) {
                    (_b97)._parent9 = (_a96)._parent9;
                }
                /* replace _c98 with _a96 in _b97 */
                (_b97)._left7 = _a96;
                if (!((_a96) == null)) {
                    (_a96)._parent9 = _b97;
                }
                /* replace _b97 with _c98 in _a96 */
                (_a96)._right8 = _c98;
                if (!((_c98) == null)) {
                    (_c98)._parent9 = _a96;
                }
                /* _min_ax12 is min of ax1 */
                var _augval99 = (_a96).ax1;
                var _child100 = (_a96)._left7;
                if (!((_child100) == null)) {
                    var _val101 = (_child100)._min_ax12;
                    _augval99 = ((_augval99) < (_val101)) ? (_augval99) : (_val101);
                }
                var _child102 = (_a96)._right8;
                if (!((_child102) == null)) {
                    var _val103 = (_child102)._min_ax12;
                    _augval99 = ((_augval99) < (_val103)) ? (_augval99) : (_val103);
                }
                (_a96)._min_ax12 = _augval99;
                /* _min_ay13 is min of ay1 */
                var _augval104 = (_a96).ay1;
                var _child105 = (_a96)._left7;
                if (!((_child105) == null)) {
                    var _val106 = (_child105)._min_ay13;
                    _augval104 = ((_augval104) < (_val106)) ? (_augval104) : (_val106);
                }
                var _child107 = (_a96)._right8;
                if (!((_child107) == null)) {
                    var _val108 = (_child107)._min_ay13;
                    _augval104 = ((_augval104) < (_val108)) ? (_augval104) : (_val108);
                }
                (_a96)._min_ay13 = _augval104;
                /* _max_ay24 is max of ay2 */
                var _augval109 = (_a96).ay2;
                var _child110 = (_a96)._left7;
                if (!((_child110) == null)) {
                    var _val111 = (_child110)._max_ay24;
                    _augval109 = ((_augval109) < (_val111)) ? (_val111) : (_augval109);
                }
                var _child112 = (_a96)._right8;
                if (!((_child112) == null)) {
                    var _val113 = (_child112)._max_ay24;
                    _augval109 = ((_augval109) < (_val113)) ? (_val113) : (_augval109);
                }
                (_a96)._max_ay24 = _augval109;
                (_a96)._height10 = 1 + ((((((_a96)._left7) == null) ? (-1) : (((_a96)._left7)._height10)) > ((((_a96)._right8) == null) ? (-1) : (((_a96)._right8)._height10))) ? ((((_a96)._left7) == null) ? (-1) : (((_a96)._left7)._height10)) : ((((_a96)._right8) == null) ? (-1) : (((_a96)._right8)._height10)));
                /* _min_ax12 is min of ax1 */
                var _augval114 = (_b97).ax1;
                var _child115 = (_b97)._left7;
                if (!((_child115) == null)) {
                    var _val116 = (_child115)._min_ax12;
                    _augval114 = ((_augval114) < (_val116)) ? (_augval114) : (_val116);
                }
                var _child117 = (_b97)._right8;
                if (!((_child117) == null)) {
                    var _val118 = (_child117)._min_ax12;
                    _augval114 = ((_augval114) < (_val118)) ? (_augval114) : (_val118);
                }
                (_b97)._min_ax12 = _augval114;
                /* _min_ay13 is min of ay1 */
                var _augval119 = (_b97).ay1;
                var _child120 = (_b97)._left7;
                if (!((_child120) == null)) {
                    var _val121 = (_child120)._min_ay13;
                    _augval119 = ((_augval119) < (_val121)) ? (_augval119) : (_val121);
                }
                var _child122 = (_b97)._right8;
                if (!((_child122) == null)) {
                    var _val123 = (_child122)._min_ay13;
                    _augval119 = ((_augval119) < (_val123)) ? (_augval119) : (_val123);
                }
                (_b97)._min_ay13 = _augval119;
                /* _max_ay24 is max of ay2 */
                var _augval124 = (_b97).ay2;
                var _child125 = (_b97)._left7;
                if (!((_child125) == null)) {
                    var _val126 = (_child125)._max_ay24;
                    _augval124 = ((_augval124) < (_val126)) ? (_val126) : (_augval124);
                }
                var _child127 = (_b97)._right8;
                if (!((_child127) == null)) {
                    var _val128 = (_child127)._max_ay24;
                    _augval124 = ((_augval124) < (_val128)) ? (_val128) : (_augval124);
                }
                (_b97)._max_ay24 = _augval124;
                (_b97)._height10 = 1 + ((((((_b97)._left7) == null) ? (-1) : (((_b97)._left7)._height10)) > ((((_b97)._right8) == null) ? (-1) : (((_b97)._right8)._height10))) ? ((((_b97)._left7) == null) ? (-1) : (((_b97)._left7)._height10)) : ((((_b97)._right8) == null) ? (-1) : (((_b97)._right8)._height10)));
                if (!(((_b97)._parent9) == null)) {
                    /* _min_ax12 is min of ax1 */
                    var _augval129 = ((_b97)._parent9).ax1;
                    var _child130 = ((_b97)._parent9)._left7;
                    if (!((_child130) == null)) {
                        var _val131 = (_child130)._min_ax12;
                        _augval129 = ((_augval129) < (_val131)) ? (_augval129) : (_val131);
                    }
                    var _child132 = ((_b97)._parent9)._right8;
                    if (!((_child132) == null)) {
                        var _val133 = (_child132)._min_ax12;
                        _augval129 = ((_augval129) < (_val133)) ? (_augval129) : (_val133);
                    }
                    ((_b97)._parent9)._min_ax12 = _augval129;
                    /* _min_ay13 is min of ay1 */
                    var _augval134 = ((_b97)._parent9).ay1;
                    var _child135 = ((_b97)._parent9)._left7;
                    if (!((_child135) == null)) {
                        var _val136 = (_child135)._min_ay13;
                        _augval134 = ((_augval134) < (_val136)) ? (_augval134) : (_val136);
                    }
                    var _child137 = ((_b97)._parent9)._right8;
                    if (!((_child137) == null)) {
                        var _val138 = (_child137)._min_ay13;
                        _augval134 = ((_augval134) < (_val138)) ? (_augval134) : (_val138);
                    }
                    ((_b97)._parent9)._min_ay13 = _augval134;
                    /* _max_ay24 is max of ay2 */
                    var _augval139 = ((_b97)._parent9).ay2;
                    var _child140 = ((_b97)._parent9)._left7;
                    if (!((_child140) == null)) {
                        var _val141 = (_child140)._max_ay24;
                        _augval139 = ((_augval139) < (_val141)) ? (_val141) : (_augval139);
                    }
                    var _child142 = ((_b97)._parent9)._right8;
                    if (!((_child142) == null)) {
                        var _val143 = (_child142)._max_ay24;
                        _augval139 = ((_augval139) < (_val143)) ? (_val143) : (_augval139);
                    }
                    ((_b97)._parent9)._max_ay24 = _augval139;
                    ((_b97)._parent9)._height10 = 1 + (((((((_b97)._parent9)._left7) == null) ? (-1) : ((((_b97)._parent9)._left7)._height10)) > (((((_b97)._parent9)._right8) == null) ? (-1) : ((((_b97)._parent9)._right8)._height10))) ? (((((_b97)._parent9)._left7) == null) ? (-1) : ((((_b97)._parent9)._left7)._height10)) : (((((_b97)._parent9)._right8) == null) ? (-1) : ((((_b97)._parent9)._right8)._height10)));
                } else {
                    (this)._root1 = _b97;
                }
            }
            /* rotate (_cursor94)._left7 */
            var _a144 = _cursor94;
            var _b145 = (_a144)._left7;
            var _c146 = (_b145)._right8;
            /* replace _a144 with _b145 in (_a144)._parent9 */
            if (!(((_a144)._parent9) == null)) {
                if ((((_a144)._parent9)._left7) == (_a144)) {
                    ((_a144)._parent9)._left7 = _b145;
                } else {
                    ((_a144)._parent9)._right8 = _b145;
                }
            }
            if (!((_b145) == null)) {
                (_b145)._parent9 = (_a144)._parent9;
            }
            /* replace _c146 with _a144 in _b145 */
            (_b145)._right8 = _a144;
            if (!((_a144) == null)) {
                (_a144)._parent9 = _b145;
            }
            /* replace _b145 with _c146 in _a144 */
            (_a144)._left7 = _c146;
            if (!((_c146) == null)) {
                (_c146)._parent9 = _a144;
            }
            /* _min_ax12 is min of ax1 */
            var _augval147 = (_a144).ax1;
            var _child148 = (_a144)._left7;
            if (!((_child148) == null)) {
                var _val149 = (_child148)._min_ax12;
                _augval147 = ((_augval147) < (_val149)) ? (_augval147) : (_val149);
            }
            var _child150 = (_a144)._right8;
            if (!((_child150) == null)) {
                var _val151 = (_child150)._min_ax12;
                _augval147 = ((_augval147) < (_val151)) ? (_augval147) : (_val151);
            }
            (_a144)._min_ax12 = _augval147;
            /* _min_ay13 is min of ay1 */
            var _augval152 = (_a144).ay1;
            var _child153 = (_a144)._left7;
            if (!((_child153) == null)) {
                var _val154 = (_child153)._min_ay13;
                _augval152 = ((_augval152) < (_val154)) ? (_augval152) : (_val154);
            }
            var _child155 = (_a144)._right8;
            if (!((_child155) == null)) {
                var _val156 = (_child155)._min_ay13;
                _augval152 = ((_augval152) < (_val156)) ? (_augval152) : (_val156);
            }
            (_a144)._min_ay13 = _augval152;
            /* _max_ay24 is max of ay2 */
            var _augval157 = (_a144).ay2;
            var _child158 = (_a144)._left7;
            if (!((_child158) == null)) {
                var _val159 = (_child158)._max_ay24;
                _augval157 = ((_augval157) < (_val159)) ? (_val159) : (_augval157);
            }
            var _child160 = (_a144)._right8;
            if (!((_child160) == null)) {
                var _val161 = (_child160)._max_ay24;
                _augval157 = ((_augval157) < (_val161)) ? (_val161) : (_augval157);
            }
            (_a144)._max_ay24 = _augval157;
            (_a144)._height10 = 1 + ((((((_a144)._left7) == null) ? (-1) : (((_a144)._left7)._height10)) > ((((_a144)._right8) == null) ? (-1) : (((_a144)._right8)._height10))) ? ((((_a144)._left7) == null) ? (-1) : (((_a144)._left7)._height10)) : ((((_a144)._right8) == null) ? (-1) : (((_a144)._right8)._height10)));
            /* _min_ax12 is min of ax1 */
            var _augval162 = (_b145).ax1;
            var _child163 = (_b145)._left7;
            if (!((_child163) == null)) {
                var _val164 = (_child163)._min_ax12;
                _augval162 = ((_augval162) < (_val164)) ? (_augval162) : (_val164);
            }
            var _child165 = (_b145)._right8;
            if (!((_child165) == null)) {
                var _val166 = (_child165)._min_ax12;
                _augval162 = ((_augval162) < (_val166)) ? (_augval162) : (_val166);
            }
            (_b145)._min_ax12 = _augval162;
            /* _min_ay13 is min of ay1 */
            var _augval167 = (_b145).ay1;
            var _child168 = (_b145)._left7;
            if (!((_child168) == null)) {
                var _val169 = (_child168)._min_ay13;
                _augval167 = ((_augval167) < (_val169)) ? (_augval167) : (_val169);
            }
            var _child170 = (_b145)._right8;
            if (!((_child170) == null)) {
                var _val171 = (_child170)._min_ay13;
                _augval167 = ((_augval167) < (_val171)) ? (_augval167) : (_val171);
            }
            (_b145)._min_ay13 = _augval167;
            /* _max_ay24 is max of ay2 */
            var _augval172 = (_b145).ay2;
            var _child173 = (_b145)._left7;
            if (!((_child173) == null)) {
                var _val174 = (_child173)._max_ay24;
                _augval172 = ((_augval172) < (_val174)) ? (_val174) : (_augval172);
            }
            var _child175 = (_b145)._right8;
            if (!((_child175) == null)) {
                var _val176 = (_child175)._max_ay24;
                _augval172 = ((_augval172) < (_val176)) ? (_val176) : (_augval172);
            }
            (_b145)._max_ay24 = _augval172;
            (_b145)._height10 = 1 + ((((((_b145)._left7) == null) ? (-1) : (((_b145)._left7)._height10)) > ((((_b145)._right8) == null) ? (-1) : (((_b145)._right8)._height10))) ? ((((_b145)._left7) == null) ? (-1) : (((_b145)._left7)._height10)) : ((((_b145)._right8) == null) ? (-1) : (((_b145)._right8)._height10)));
            if (!(((_b145)._parent9) == null)) {
                /* _min_ax12 is min of ax1 */
                var _augval177 = ((_b145)._parent9).ax1;
                var _child178 = ((_b145)._parent9)._left7;
                if (!((_child178) == null)) {
                    var _val179 = (_child178)._min_ax12;
                    _augval177 = ((_augval177) < (_val179)) ? (_augval177) : (_val179);
                }
                var _child180 = ((_b145)._parent9)._right8;
                if (!((_child180) == null)) {
                    var _val181 = (_child180)._min_ax12;
                    _augval177 = ((_augval177) < (_val181)) ? (_augval177) : (_val181);
                }
                ((_b145)._parent9)._min_ax12 = _augval177;
                /* _min_ay13 is min of ay1 */
                var _augval182 = ((_b145)._parent9).ay1;
                var _child183 = ((_b145)._parent9)._left7;
                if (!((_child183) == null)) {
                    var _val184 = (_child183)._min_ay13;
                    _augval182 = ((_augval182) < (_val184)) ? (_augval182) : (_val184);
                }
                var _child185 = ((_b145)._parent9)._right8;
                if (!((_child185) == null)) {
                    var _val186 = (_child185)._min_ay13;
                    _augval182 = ((_augval182) < (_val186)) ? (_augval182) : (_val186);
                }
                ((_b145)._parent9)._min_ay13 = _augval182;
                /* _max_ay24 is max of ay2 */
                var _augval187 = ((_b145)._parent9).ay2;
                var _child188 = ((_b145)._parent9)._left7;
                if (!((_child188) == null)) {
                    var _val189 = (_child188)._max_ay24;
                    _augval187 = ((_augval187) < (_val189)) ? (_val189) : (_augval187);
                }
                var _child190 = ((_b145)._parent9)._right8;
                if (!((_child190) == null)) {
                    var _val191 = (_child190)._max_ay24;
                    _augval187 = ((_augval187) < (_val191)) ? (_val191) : (_augval187);
                }
                ((_b145)._parent9)._max_ay24 = _augval187;
                ((_b145)._parent9)._height10 = 1 + (((((((_b145)._parent9)._left7) == null) ? (-1) : ((((_b145)._parent9)._left7)._height10)) > (((((_b145)._parent9)._right8) == null) ? (-1) : ((((_b145)._parent9)._right8)._height10))) ? (((((_b145)._parent9)._left7) == null) ? (-1) : ((((_b145)._parent9)._left7)._height10)) : (((((_b145)._parent9)._right8) == null) ? (-1) : ((((_b145)._parent9)._right8)._height10)));
            } else {
                (this)._root1 = _b145;
            }
            _cursor94 = (_cursor94)._parent9;
        } else if ((_imbalance95) < (-1)) {
            if ((((((_cursor94)._right8)._left7) == null) ? (-1) : ((((_cursor94)._right8)._left7)._height10)) > (((((_cursor94)._right8)._right8) == null) ? (-1) : ((((_cursor94)._right8)._right8)._height10))) {
                /* rotate ((_cursor94)._right8)._left7 */
                var _a192 = (_cursor94)._right8;
                var _b193 = (_a192)._left7;
                var _c194 = (_b193)._right8;
                /* replace _a192 with _b193 in (_a192)._parent9 */
                if (!(((_a192)._parent9) == null)) {
                    if ((((_a192)._parent9)._left7) == (_a192)) {
                        ((_a192)._parent9)._left7 = _b193;
                    } else {
                        ((_a192)._parent9)._right8 = _b193;
                    }
                }
                if (!((_b193) == null)) {
                    (_b193)._parent9 = (_a192)._parent9;
                }
                /* replace _c194 with _a192 in _b193 */
                (_b193)._right8 = _a192;
                if (!((_a192) == null)) {
                    (_a192)._parent9 = _b193;
                }
                /* replace _b193 with _c194 in _a192 */
                (_a192)._left7 = _c194;
                if (!((_c194) == null)) {
                    (_c194)._parent9 = _a192;
                }
                /* _min_ax12 is min of ax1 */
                var _augval195 = (_a192).ax1;
                var _child196 = (_a192)._left7;
                if (!((_child196) == null)) {
                    var _val197 = (_child196)._min_ax12;
                    _augval195 = ((_augval195) < (_val197)) ? (_augval195) : (_val197);
                }
                var _child198 = (_a192)._right8;
                if (!((_child198) == null)) {
                    var _val199 = (_child198)._min_ax12;
                    _augval195 = ((_augval195) < (_val199)) ? (_augval195) : (_val199);
                }
                (_a192)._min_ax12 = _augval195;
                /* _min_ay13 is min of ay1 */
                var _augval200 = (_a192).ay1;
                var _child201 = (_a192)._left7;
                if (!((_child201) == null)) {
                    var _val202 = (_child201)._min_ay13;
                    _augval200 = ((_augval200) < (_val202)) ? (_augval200) : (_val202);
                }
                var _child203 = (_a192)._right8;
                if (!((_child203) == null)) {
                    var _val204 = (_child203)._min_ay13;
                    _augval200 = ((_augval200) < (_val204)) ? (_augval200) : (_val204);
                }
                (_a192)._min_ay13 = _augval200;
                /* _max_ay24 is max of ay2 */
                var _augval205 = (_a192).ay2;
                var _child206 = (_a192)._left7;
                if (!((_child206) == null)) {
                    var _val207 = (_child206)._max_ay24;
                    _augval205 = ((_augval205) < (_val207)) ? (_val207) : (_augval205);
                }
                var _child208 = (_a192)._right8;
                if (!((_child208) == null)) {
                    var _val209 = (_child208)._max_ay24;
                    _augval205 = ((_augval205) < (_val209)) ? (_val209) : (_augval205);
                }
                (_a192)._max_ay24 = _augval205;
                (_a192)._height10 = 1 + ((((((_a192)._left7) == null) ? (-1) : (((_a192)._left7)._height10)) > ((((_a192)._right8) == null) ? (-1) : (((_a192)._right8)._height10))) ? ((((_a192)._left7) == null) ? (-1) : (((_a192)._left7)._height10)) : ((((_a192)._right8) == null) ? (-1) : (((_a192)._right8)._height10)));
                /* _min_ax12 is min of ax1 */
                var _augval210 = (_b193).ax1;
                var _child211 = (_b193)._left7;
                if (!((_child211) == null)) {
                    var _val212 = (_child211)._min_ax12;
                    _augval210 = ((_augval210) < (_val212)) ? (_augval210) : (_val212);
                }
                var _child213 = (_b193)._right8;
                if (!((_child213) == null)) {
                    var _val214 = (_child213)._min_ax12;
                    _augval210 = ((_augval210) < (_val214)) ? (_augval210) : (_val214);
                }
                (_b193)._min_ax12 = _augval210;
                /* _min_ay13 is min of ay1 */
                var _augval215 = (_b193).ay1;
                var _child216 = (_b193)._left7;
                if (!((_child216) == null)) {
                    var _val217 = (_child216)._min_ay13;
                    _augval215 = ((_augval215) < (_val217)) ? (_augval215) : (_val217);
                }
                var _child218 = (_b193)._right8;
                if (!((_child218) == null)) {
                    var _val219 = (_child218)._min_ay13;
                    _augval215 = ((_augval215) < (_val219)) ? (_augval215) : (_val219);
                }
                (_b193)._min_ay13 = _augval215;
                /* _max_ay24 is max of ay2 */
                var _augval220 = (_b193).ay2;
                var _child221 = (_b193)._left7;
                if (!((_child221) == null)) {
                    var _val222 = (_child221)._max_ay24;
                    _augval220 = ((_augval220) < (_val222)) ? (_val222) : (_augval220);
                }
                var _child223 = (_b193)._right8;
                if (!((_child223) == null)) {
                    var _val224 = (_child223)._max_ay24;
                    _augval220 = ((_augval220) < (_val224)) ? (_val224) : (_augval220);
                }
                (_b193)._max_ay24 = _augval220;
                (_b193)._height10 = 1 + ((((((_b193)._left7) == null) ? (-1) : (((_b193)._left7)._height10)) > ((((_b193)._right8) == null) ? (-1) : (((_b193)._right8)._height10))) ? ((((_b193)._left7) == null) ? (-1) : (((_b193)._left7)._height10)) : ((((_b193)._right8) == null) ? (-1) : (((_b193)._right8)._height10)));
                if (!(((_b193)._parent9) == null)) {
                    /* _min_ax12 is min of ax1 */
                    var _augval225 = ((_b193)._parent9).ax1;
                    var _child226 = ((_b193)._parent9)._left7;
                    if (!((_child226) == null)) {
                        var _val227 = (_child226)._min_ax12;
                        _augval225 = ((_augval225) < (_val227)) ? (_augval225) : (_val227);
                    }
                    var _child228 = ((_b193)._parent9)._right8;
                    if (!((_child228) == null)) {
                        var _val229 = (_child228)._min_ax12;
                        _augval225 = ((_augval225) < (_val229)) ? (_augval225) : (_val229);
                    }
                    ((_b193)._parent9)._min_ax12 = _augval225;
                    /* _min_ay13 is min of ay1 */
                    var _augval230 = ((_b193)._parent9).ay1;
                    var _child231 = ((_b193)._parent9)._left7;
                    if (!((_child231) == null)) {
                        var _val232 = (_child231)._min_ay13;
                        _augval230 = ((_augval230) < (_val232)) ? (_augval230) : (_val232);
                    }
                    var _child233 = ((_b193)._parent9)._right8;
                    if (!((_child233) == null)) {
                        var _val234 = (_child233)._min_ay13;
                        _augval230 = ((_augval230) < (_val234)) ? (_augval230) : (_val234);
                    }
                    ((_b193)._parent9)._min_ay13 = _augval230;
                    /* _max_ay24 is max of ay2 */
                    var _augval235 = ((_b193)._parent9).ay2;
                    var _child236 = ((_b193)._parent9)._left7;
                    if (!((_child236) == null)) {
                        var _val237 = (_child236)._max_ay24;
                        _augval235 = ((_augval235) < (_val237)) ? (_val237) : (_augval235);
                    }
                    var _child238 = ((_b193)._parent9)._right8;
                    if (!((_child238) == null)) {
                        var _val239 = (_child238)._max_ay24;
                        _augval235 = ((_augval235) < (_val239)) ? (_val239) : (_augval235);
                    }
                    ((_b193)._parent9)._max_ay24 = _augval235;
                    ((_b193)._parent9)._height10 = 1 + (((((((_b193)._parent9)._left7) == null) ? (-1) : ((((_b193)._parent9)._left7)._height10)) > (((((_b193)._parent9)._right8) == null) ? (-1) : ((((_b193)._parent9)._right8)._height10))) ? (((((_b193)._parent9)._left7) == null) ? (-1) : ((((_b193)._parent9)._left7)._height10)) : (((((_b193)._parent9)._right8) == null) ? (-1) : ((((_b193)._parent9)._right8)._height10)));
                } else {
                    (this)._root1 = _b193;
                }
            }
            /* rotate (_cursor94)._right8 */
            var _a240 = _cursor94;
            var _b241 = (_a240)._right8;
            var _c242 = (_b241)._left7;
            /* replace _a240 with _b241 in (_a240)._parent9 */
            if (!(((_a240)._parent9) == null)) {
                if ((((_a240)._parent9)._left7) == (_a240)) {
                    ((_a240)._parent9)._left7 = _b241;
                } else {
                    ((_a240)._parent9)._right8 = _b241;
                }
            }
            if (!((_b241) == null)) {
                (_b241)._parent9 = (_a240)._parent9;
            }
            /* replace _c242 with _a240 in _b241 */
            (_b241)._left7 = _a240;
            if (!((_a240) == null)) {
                (_a240)._parent9 = _b241;
            }
            /* replace _b241 with _c242 in _a240 */
            (_a240)._right8 = _c242;
            if (!((_c242) == null)) {
                (_c242)._parent9 = _a240;
            }
            /* _min_ax12 is min of ax1 */
            var _augval243 = (_a240).ax1;
            var _child244 = (_a240)._left7;
            if (!((_child244) == null)) {
                var _val245 = (_child244)._min_ax12;
                _augval243 = ((_augval243) < (_val245)) ? (_augval243) : (_val245);
            }
            var _child246 = (_a240)._right8;
            if (!((_child246) == null)) {
                var _val247 = (_child246)._min_ax12;
                _augval243 = ((_augval243) < (_val247)) ? (_augval243) : (_val247);
            }
            (_a240)._min_ax12 = _augval243;
            /* _min_ay13 is min of ay1 */
            var _augval248 = (_a240).ay1;
            var _child249 = (_a240)._left7;
            if (!((_child249) == null)) {
                var _val250 = (_child249)._min_ay13;
                _augval248 = ((_augval248) < (_val250)) ? (_augval248) : (_val250);
            }
            var _child251 = (_a240)._right8;
            if (!((_child251) == null)) {
                var _val252 = (_child251)._min_ay13;
                _augval248 = ((_augval248) < (_val252)) ? (_augval248) : (_val252);
            }
            (_a240)._min_ay13 = _augval248;
            /* _max_ay24 is max of ay2 */
            var _augval253 = (_a240).ay2;
            var _child254 = (_a240)._left7;
            if (!((_child254) == null)) {
                var _val255 = (_child254)._max_ay24;
                _augval253 = ((_augval253) < (_val255)) ? (_val255) : (_augval253);
            }
            var _child256 = (_a240)._right8;
            if (!((_child256) == null)) {
                var _val257 = (_child256)._max_ay24;
                _augval253 = ((_augval253) < (_val257)) ? (_val257) : (_augval253);
            }
            (_a240)._max_ay24 = _augval253;
            (_a240)._height10 = 1 + ((((((_a240)._left7) == null) ? (-1) : (((_a240)._left7)._height10)) > ((((_a240)._right8) == null) ? (-1) : (((_a240)._right8)._height10))) ? ((((_a240)._left7) == null) ? (-1) : (((_a240)._left7)._height10)) : ((((_a240)._right8) == null) ? (-1) : (((_a240)._right8)._height10)));
            /* _min_ax12 is min of ax1 */
            var _augval258 = (_b241).ax1;
            var _child259 = (_b241)._left7;
            if (!((_child259) == null)) {
                var _val260 = (_child259)._min_ax12;
                _augval258 = ((_augval258) < (_val260)) ? (_augval258) : (_val260);
            }
            var _child261 = (_b241)._right8;
            if (!((_child261) == null)) {
                var _val262 = (_child261)._min_ax12;
                _augval258 = ((_augval258) < (_val262)) ? (_augval258) : (_val262);
            }
            (_b241)._min_ax12 = _augval258;
            /* _min_ay13 is min of ay1 */
            var _augval263 = (_b241).ay1;
            var _child264 = (_b241)._left7;
            if (!((_child264) == null)) {
                var _val265 = (_child264)._min_ay13;
                _augval263 = ((_augval263) < (_val265)) ? (_augval263) : (_val265);
            }
            var _child266 = (_b241)._right8;
            if (!((_child266) == null)) {
                var _val267 = (_child266)._min_ay13;
                _augval263 = ((_augval263) < (_val267)) ? (_augval263) : (_val267);
            }
            (_b241)._min_ay13 = _augval263;
            /* _max_ay24 is max of ay2 */
            var _augval268 = (_b241).ay2;
            var _child269 = (_b241)._left7;
            if (!((_child269) == null)) {
                var _val270 = (_child269)._max_ay24;
                _augval268 = ((_augval268) < (_val270)) ? (_val270) : (_augval268);
            }
            var _child271 = (_b241)._right8;
            if (!((_child271) == null)) {
                var _val272 = (_child271)._max_ay24;
                _augval268 = ((_augval268) < (_val272)) ? (_val272) : (_augval268);
            }
            (_b241)._max_ay24 = _augval268;
            (_b241)._height10 = 1 + ((((((_b241)._left7) == null) ? (-1) : (((_b241)._left7)._height10)) > ((((_b241)._right8) == null) ? (-1) : (((_b241)._right8)._height10))) ? ((((_b241)._left7) == null) ? (-1) : (((_b241)._left7)._height10)) : ((((_b241)._right8) == null) ? (-1) : (((_b241)._right8)._height10)));
            if (!(((_b241)._parent9) == null)) {
                /* _min_ax12 is min of ax1 */
                var _augval273 = ((_b241)._parent9).ax1;
                var _child274 = ((_b241)._parent9)._left7;
                if (!((_child274) == null)) {
                    var _val275 = (_child274)._min_ax12;
                    _augval273 = ((_augval273) < (_val275)) ? (_augval273) : (_val275);
                }
                var _child276 = ((_b241)._parent9)._right8;
                if (!((_child276) == null)) {
                    var _val277 = (_child276)._min_ax12;
                    _augval273 = ((_augval273) < (_val277)) ? (_augval273) : (_val277);
                }
                ((_b241)._parent9)._min_ax12 = _augval273;
                /* _min_ay13 is min of ay1 */
                var _augval278 = ((_b241)._parent9).ay1;
                var _child279 = ((_b241)._parent9)._left7;
                if (!((_child279) == null)) {
                    var _val280 = (_child279)._min_ay13;
                    _augval278 = ((_augval278) < (_val280)) ? (_augval278) : (_val280);
                }
                var _child281 = ((_b241)._parent9)._right8;
                if (!((_child281) == null)) {
                    var _val282 = (_child281)._min_ay13;
                    _augval278 = ((_augval278) < (_val282)) ? (_augval278) : (_val282);
                }
                ((_b241)._parent9)._min_ay13 = _augval278;
                /* _max_ay24 is max of ay2 */
                var _augval283 = ((_b241)._parent9).ay2;
                var _child284 = ((_b241)._parent9)._left7;
                if (!((_child284) == null)) {
                    var _val285 = (_child284)._max_ay24;
                    _augval283 = ((_augval283) < (_val285)) ? (_val285) : (_augval283);
                }
                var _child286 = ((_b241)._parent9)._right8;
                if (!((_child286) == null)) {
                    var _val287 = (_child286)._max_ay24;
                    _augval283 = ((_augval283) < (_val287)) ? (_val287) : (_augval283);
                }
                ((_b241)._parent9)._max_ay24 = _augval283;
                ((_b241)._parent9)._height10 = 1 + (((((((_b241)._parent9)._left7) == null) ? (-1) : ((((_b241)._parent9)._left7)._height10)) > (((((_b241)._parent9)._right8) == null) ? (-1) : ((((_b241)._parent9)._right8)._height10))) ? (((((_b241)._parent9)._left7) == null) ? (-1) : ((((_b241)._parent9)._left7)._height10)) : (((((_b241)._parent9)._right8) == null) ? (-1) : ((((_b241)._parent9)._right8)._height10)));
            } else {
                (this)._root1 = _b241;
            }
            _cursor94 = (_cursor94)._parent9;
        }
    }
};
RectangleHolder.prototype.remove = function (x) {
    --this.my_size;
    var _parent288 = (x)._parent9;
    var _left289 = (x)._left7;
    var _right290 = (x)._right8;
    var _new_x291;
    if (((_left289) == null) && ((_right290) == null)) {
        _new_x291 = null;
        /* replace x with _new_x291 in _parent288 */
        if (!((_parent288) == null)) {
            if (((_parent288)._left7) == (x)) {
                (_parent288)._left7 = _new_x291;
            } else {
                (_parent288)._right8 = _new_x291;
            }
        }
        if (!((_new_x291) == null)) {
            (_new_x291)._parent9 = _parent288;
        }
    } else if ((!((_left289) == null)) && ((_right290) == null)) {
        _new_x291 = _left289;
        /* replace x with _new_x291 in _parent288 */
        if (!((_parent288) == null)) {
            if (((_parent288)._left7) == (x)) {
                (_parent288)._left7 = _new_x291;
            } else {
                (_parent288)._right8 = _new_x291;
            }
        }
        if (!((_new_x291) == null)) {
            (_new_x291)._parent9 = _parent288;
        }
    } else if (((_left289) == null) && (!((_right290) == null))) {
        _new_x291 = _right290;
        /* replace x with _new_x291 in _parent288 */
        if (!((_parent288) == null)) {
            if (((_parent288)._left7) == (x)) {
                (_parent288)._left7 = _new_x291;
            } else {
                (_parent288)._right8 = _new_x291;
            }
        }
        if (!((_new_x291) == null)) {
            (_new_x291)._parent9 = _parent288;
        }
    } else {
        var _root292 = (x)._right8;
        var _x293 = _root292;
        var _descend294 = true;
        var _from_left295 = true;
        while (true) {
            if ((_x293) == null) {
                _x293 = null;
                break;
            }
            if (_descend294) {
                /* too small? */
                if (false) {
                    if ((!(((_x293)._right8) == null)) && (true)) {
                        if ((_x293) == (_root292)) {
                            _root292 = (_x293)._right8;
                        }
                        _x293 = (_x293)._right8;
                    } else if ((_x293) == (_root292)) {
                        _x293 = null;
                        break;
                    } else {
                        _descend294 = false;
                        _from_left295 = (!(((_x293)._parent9) == null)) && ((_x293) == (((_x293)._parent9)._left7));
                        _x293 = (_x293)._parent9;
                    }
                } else if ((!(((_x293)._left7) == null)) && (true)) {
                    _x293 = (_x293)._left7;
                    /* too large? */
                } else if (false) {
                    if ((_x293) == (_root292)) {
                        _x293 = null;
                        break;
                    } else {
                        _descend294 = false;
                        _from_left295 = (!(((_x293)._parent9) == null)) && ((_x293) == (((_x293)._parent9)._left7));
                        _x293 = (_x293)._parent9;
                    }
                    /* node ok? */
                } else if (true) {
                    break;
                } else if ((_x293) == (_root292)) {
                    _root292 = (_x293)._right8;
                    _x293 = (_x293)._right8;
                } else {
                    if ((!(((_x293)._right8) == null)) && (true)) {
                        if ((_x293) == (_root292)) {
                            _root292 = (_x293)._right8;
                        }
                        _x293 = (_x293)._right8;
                    } else {
                        _descend294 = false;
                        _from_left295 = (!(((_x293)._parent9) == null)) && ((_x293) == (((_x293)._parent9)._left7));
                        _x293 = (_x293)._parent9;
                    }
                }
            } else if (_from_left295) {
                if (false) {
                    _x293 = null;
                    break;
                } else if (true) {
                    break;
                } else if ((!(((_x293)._right8) == null)) && (true)) {
                    _descend294 = true;
                    if ((_x293) == (_root292)) {
                        _root292 = (_x293)._right8;
                    }
                    _x293 = (_x293)._right8;
                } else if ((_x293) == (_root292)) {
                    _x293 = null;
                    break;
                } else {
                    _descend294 = false;
                    _from_left295 = (!(((_x293)._parent9) == null)) && ((_x293) == (((_x293)._parent9)._left7));
                    _x293 = (_x293)._parent9;
                }
            } else {
                if ((_x293) == (_root292)) {
                    _x293 = null;
                    break;
                } else {
                    _descend294 = false;
                    _from_left295 = (!(((_x293)._parent9) == null)) && ((_x293) == (((_x293)._parent9)._left7));
                    _x293 = (_x293)._parent9;
                }
            }
        }
        _new_x291 = _x293;
        var _mp296 = (_x293)._parent9;
        var _mr297 = (_x293)._right8;
        /* replace _x293 with _mr297 in _mp296 */
        if (!((_mp296) == null)) {
            if (((_mp296)._left7) == (_x293)) {
                (_mp296)._left7 = _mr297;
            } else {
                (_mp296)._right8 = _mr297;
            }
        }
        if (!((_mr297) == null)) {
            (_mr297)._parent9 = _mp296;
        }
        /* replace x with _x293 in _parent288 */
        if (!((_parent288) == null)) {
            if (((_parent288)._left7) == (x)) {
                (_parent288)._left7 = _x293;
            } else {
                (_parent288)._right8 = _x293;
            }
        }
        if (!((_x293) == null)) {
            (_x293)._parent9 = _parent288;
        }
        /* replace null with _left289 in _x293 */
        (_x293)._left7 = _left289;
        if (!((_left289) == null)) {
            (_left289)._parent9 = _x293;
        }
        /* replace _mr297 with (x)._right8 in _x293 */
        (_x293)._right8 = (x)._right8;
        if (!(((x)._right8) == null)) {
            ((x)._right8)._parent9 = _x293;
        }
        /* _min_ax12 is min of ax1 */
        var _augval298 = (_x293).ax1;
        var _child299 = (_x293)._left7;
        if (!((_child299) == null)) {
            var _val300 = (_child299)._min_ax12;
            _augval298 = ((_augval298) < (_val300)) ? (_augval298) : (_val300);
        }
        var _child301 = (_x293)._right8;
        if (!((_child301) == null)) {
            var _val302 = (_child301)._min_ax12;
            _augval298 = ((_augval298) < (_val302)) ? (_augval298) : (_val302);
        }
        (_x293)._min_ax12 = _augval298;
        /* _min_ay13 is min of ay1 */
        var _augval303 = (_x293).ay1;
        var _child304 = (_x293)._left7;
        if (!((_child304) == null)) {
            var _val305 = (_child304)._min_ay13;
            _augval303 = ((_augval303) < (_val305)) ? (_augval303) : (_val305);
        }
        var _child306 = (_x293)._right8;
        if (!((_child306) == null)) {
            var _val307 = (_child306)._min_ay13;
            _augval303 = ((_augval303) < (_val307)) ? (_augval303) : (_val307);
        }
        (_x293)._min_ay13 = _augval303;
        /* _max_ay24 is max of ay2 */
        var _augval308 = (_x293).ay2;
        var _child309 = (_x293)._left7;
        if (!((_child309) == null)) {
            var _val310 = (_child309)._max_ay24;
            _augval308 = ((_augval308) < (_val310)) ? (_val310) : (_augval308);
        }
        var _child311 = (_x293)._right8;
        if (!((_child311) == null)) {
            var _val312 = (_child311)._max_ay24;
            _augval308 = ((_augval308) < (_val312)) ? (_val312) : (_augval308);
        }
        (_x293)._max_ay24 = _augval308;
        (_x293)._height10 = 1 + ((((((_x293)._left7) == null) ? (-1) : (((_x293)._left7)._height10)) > ((((_x293)._right8) == null) ? (-1) : (((_x293)._right8)._height10))) ? ((((_x293)._left7) == null) ? (-1) : (((_x293)._left7)._height10)) : ((((_x293)._right8) == null) ? (-1) : (((_x293)._right8)._height10)));
        var _cursor313 = _mp296;
        var _changed314 = true;
        while ((_changed314) && (!((_cursor313) == (_parent288)))) {
            var _old__min_ax12315 = (_cursor313)._min_ax12;
            var _old__min_ay13316 = (_cursor313)._min_ay13;
            var _old__max_ay24317 = (_cursor313)._max_ay24;
            var _old_height318 = (_cursor313)._height10;
            /* _min_ax12 is min of ax1 */
            var _augval319 = (_cursor313).ax1;
            var _child320 = (_cursor313)._left7;
            if (!((_child320) == null)) {
                var _val321 = (_child320)._min_ax12;
                _augval319 = ((_augval319) < (_val321)) ? (_augval319) : (_val321);
            }
            var _child322 = (_cursor313)._right8;
            if (!((_child322) == null)) {
                var _val323 = (_child322)._min_ax12;
                _augval319 = ((_augval319) < (_val323)) ? (_augval319) : (_val323);
            }
            (_cursor313)._min_ax12 = _augval319;
            /* _min_ay13 is min of ay1 */
            var _augval324 = (_cursor313).ay1;
            var _child325 = (_cursor313)._left7;
            if (!((_child325) == null)) {
                var _val326 = (_child325)._min_ay13;
                _augval324 = ((_augval324) < (_val326)) ? (_augval324) : (_val326);
            }
            var _child327 = (_cursor313)._right8;
            if (!((_child327) == null)) {
                var _val328 = (_child327)._min_ay13;
                _augval324 = ((_augval324) < (_val328)) ? (_augval324) : (_val328);
            }
            (_cursor313)._min_ay13 = _augval324;
            /* _max_ay24 is max of ay2 */
            var _augval329 = (_cursor313).ay2;
            var _child330 = (_cursor313)._left7;
            if (!((_child330) == null)) {
                var _val331 = (_child330)._max_ay24;
                _augval329 = ((_augval329) < (_val331)) ? (_val331) : (_augval329);
            }
            var _child332 = (_cursor313)._right8;
            if (!((_child332) == null)) {
                var _val333 = (_child332)._max_ay24;
                _augval329 = ((_augval329) < (_val333)) ? (_val333) : (_augval329);
            }
            (_cursor313)._max_ay24 = _augval329;
            (_cursor313)._height10 = 1 + ((((((_cursor313)._left7) == null) ? (-1) : (((_cursor313)._left7)._height10)) > ((((_cursor313)._right8) == null) ? (-1) : (((_cursor313)._right8)._height10))) ? ((((_cursor313)._left7) == null) ? (-1) : (((_cursor313)._left7)._height10)) : ((((_cursor313)._right8) == null) ? (-1) : (((_cursor313)._right8)._height10)));
            _changed314 = false;
            _changed314 = (_changed314) || (!((_old__min_ax12315) == ((_cursor313)._min_ax12)));
            _changed314 = (_changed314) || (!((_old__min_ay13316) == ((_cursor313)._min_ay13)));
            _changed314 = (_changed314) || (!((_old__max_ay24317) == ((_cursor313)._max_ay24)));
            _changed314 = (_changed314) || (!((_old_height318) == ((_cursor313)._height10)));
            _cursor313 = (_cursor313)._parent9;
        }
    }
    var _cursor334 = _parent288;
    var _changed335 = true;
    while ((_changed335) && (!((_cursor334) == (null)))) {
        var _old__min_ax12336 = (_cursor334)._min_ax12;
        var _old__min_ay13337 = (_cursor334)._min_ay13;
        var _old__max_ay24338 = (_cursor334)._max_ay24;
        var _old_height339 = (_cursor334)._height10;
        /* _min_ax12 is min of ax1 */
        var _augval340 = (_cursor334).ax1;
        var _child341 = (_cursor334)._left7;
        if (!((_child341) == null)) {
            var _val342 = (_child341)._min_ax12;
            _augval340 = ((_augval340) < (_val342)) ? (_augval340) : (_val342);
        }
        var _child343 = (_cursor334)._right8;
        if (!((_child343) == null)) {
            var _val344 = (_child343)._min_ax12;
            _augval340 = ((_augval340) < (_val344)) ? (_augval340) : (_val344);
        }
        (_cursor334)._min_ax12 = _augval340;
        /* _min_ay13 is min of ay1 */
        var _augval345 = (_cursor334).ay1;
        var _child346 = (_cursor334)._left7;
        if (!((_child346) == null)) {
            var _val347 = (_child346)._min_ay13;
            _augval345 = ((_augval345) < (_val347)) ? (_augval345) : (_val347);
        }
        var _child348 = (_cursor334)._right8;
        if (!((_child348) == null)) {
            var _val349 = (_child348)._min_ay13;
            _augval345 = ((_augval345) < (_val349)) ? (_augval345) : (_val349);
        }
        (_cursor334)._min_ay13 = _augval345;
        /* _max_ay24 is max of ay2 */
        var _augval350 = (_cursor334).ay2;
        var _child351 = (_cursor334)._left7;
        if (!((_child351) == null)) {
            var _val352 = (_child351)._max_ay24;
            _augval350 = ((_augval350) < (_val352)) ? (_val352) : (_augval350);
        }
        var _child353 = (_cursor334)._right8;
        if (!((_child353) == null)) {
            var _val354 = (_child353)._max_ay24;
            _augval350 = ((_augval350) < (_val354)) ? (_val354) : (_augval350);
        }
        (_cursor334)._max_ay24 = _augval350;
        (_cursor334)._height10 = 1 + ((((((_cursor334)._left7) == null) ? (-1) : (((_cursor334)._left7)._height10)) > ((((_cursor334)._right8) == null) ? (-1) : (((_cursor334)._right8)._height10))) ? ((((_cursor334)._left7) == null) ? (-1) : (((_cursor334)._left7)._height10)) : ((((_cursor334)._right8) == null) ? (-1) : (((_cursor334)._right8)._height10)));
        _changed335 = false;
        _changed335 = (_changed335) || (!((_old__min_ax12336) == ((_cursor334)._min_ax12)));
        _changed335 = (_changed335) || (!((_old__min_ay13337) == ((_cursor334)._min_ay13)));
        _changed335 = (_changed335) || (!((_old__max_ay24338) == ((_cursor334)._max_ay24)));
        _changed335 = (_changed335) || (!((_old_height339) == ((_cursor334)._height10)));
        _cursor334 = (_cursor334)._parent9;
    }
    if (((this)._root1) == (x)) {
        (this)._root1 = _new_x291;
    }
};
RectangleHolder.prototype.updateAx1 = function (__x, new_val) {
    if ((__x).ax1 != new_val) {
        /* _min_ax12 is min of ax1 */
        var _augval355 = new_val;
        var _child356 = (__x)._left7;
        if (!((_child356) == null)) {
            var _val357 = (_child356)._min_ax12;
            _augval355 = ((_augval355) < (_val357)) ? (_augval355) : (_val357);
        }
        var _child358 = (__x)._right8;
        if (!((_child358) == null)) {
            var _val359 = (_child358)._min_ax12;
            _augval355 = ((_augval355) < (_val359)) ? (_augval355) : (_val359);
        }
        (__x)._min_ax12 = _augval355;
        var _cursor360 = (__x)._parent9;
        var _changed361 = true;
        while ((_changed361) && (!((_cursor360) == (null)))) {
            var _old__min_ax12362 = (_cursor360)._min_ax12;
            var _old_height363 = (_cursor360)._height10;
            /* _min_ax12 is min of ax1 */
            var _augval364 = (_cursor360).ax1;
            var _child365 = (_cursor360)._left7;
            if (!((_child365) == null)) {
                var _val366 = (_child365)._min_ax12;
                _augval364 = ((_augval364) < (_val366)) ? (_augval364) : (_val366);
            }
            var _child367 = (_cursor360)._right8;
            if (!((_child367) == null)) {
                var _val368 = (_child367)._min_ax12;
                _augval364 = ((_augval364) < (_val368)) ? (_augval364) : (_val368);
            }
            (_cursor360)._min_ax12 = _augval364;
            (_cursor360)._height10 = 1 + ((((((_cursor360)._left7) == null) ? (-1) : (((_cursor360)._left7)._height10)) > ((((_cursor360)._right8) == null) ? (-1) : (((_cursor360)._right8)._height10))) ? ((((_cursor360)._left7) == null) ? (-1) : (((_cursor360)._left7)._height10)) : ((((_cursor360)._right8) == null) ? (-1) : (((_cursor360)._right8)._height10)));
            _changed361 = false;
            _changed361 = (_changed361) || (!((_old__min_ax12362) == ((_cursor360)._min_ax12)));
            _changed361 = (_changed361) || (!((_old_height363) == ((_cursor360)._height10)));
            _cursor360 = (_cursor360)._parent9;
        }
        (__x).ax1 = new_val;
    }
}
RectangleHolder.prototype.updateAy1 = function (__x, new_val) {
    if ((__x).ay1 != new_val) {
        /* _min_ay13 is min of ay1 */
        var _augval369 = new_val;
        var _child370 = (__x)._left7;
        if (!((_child370) == null)) {
            var _val371 = (_child370)._min_ay13;
            _augval369 = ((_augval369) < (_val371)) ? (_augval369) : (_val371);
        }
        var _child372 = (__x)._right8;
        if (!((_child372) == null)) {
            var _val373 = (_child372)._min_ay13;
            _augval369 = ((_augval369) < (_val373)) ? (_augval369) : (_val373);
        }
        (__x)._min_ay13 = _augval369;
        var _cursor374 = (__x)._parent9;
        var _changed375 = true;
        while ((_changed375) && (!((_cursor374) == (null)))) {
            var _old__min_ay13376 = (_cursor374)._min_ay13;
            var _old_height377 = (_cursor374)._height10;
            /* _min_ay13 is min of ay1 */
            var _augval378 = (_cursor374).ay1;
            var _child379 = (_cursor374)._left7;
            if (!((_child379) == null)) {
                var _val380 = (_child379)._min_ay13;
                _augval378 = ((_augval378) < (_val380)) ? (_augval378) : (_val380);
            }
            var _child381 = (_cursor374)._right8;
            if (!((_child381) == null)) {
                var _val382 = (_child381)._min_ay13;
                _augval378 = ((_augval378) < (_val382)) ? (_augval378) : (_val382);
            }
            (_cursor374)._min_ay13 = _augval378;
            (_cursor374)._height10 = 1 + ((((((_cursor374)._left7) == null) ? (-1) : (((_cursor374)._left7)._height10)) > ((((_cursor374)._right8) == null) ? (-1) : (((_cursor374)._right8)._height10))) ? ((((_cursor374)._left7) == null) ? (-1) : (((_cursor374)._left7)._height10)) : ((((_cursor374)._right8) == null) ? (-1) : (((_cursor374)._right8)._height10)));
            _changed375 = false;
            _changed375 = (_changed375) || (!((_old__min_ay13376) == ((_cursor374)._min_ay13)));
            _changed375 = (_changed375) || (!((_old_height377) == ((_cursor374)._height10)));
            _cursor374 = (_cursor374)._parent9;
        }
        (__x).ay1 = new_val;
    }
}
RectangleHolder.prototype.updateAx2 = function (__x, new_val) {
    if ((__x).ax2 != new_val) {
        var _parent383 = (__x)._parent9;
        var _left384 = (__x)._left7;
        var _right385 = (__x)._right8;
        var _new_x386;
        if (((_left384) == null) && ((_right385) == null)) {
            _new_x386 = null;
            /* replace __x with _new_x386 in _parent383 */
            if (!((_parent383) == null)) {
                if (((_parent383)._left7) == (__x)) {
                    (_parent383)._left7 = _new_x386;
                } else {
                    (_parent383)._right8 = _new_x386;
                }
            }
            if (!((_new_x386) == null)) {
                (_new_x386)._parent9 = _parent383;
            }
        } else if ((!((_left384) == null)) && ((_right385) == null)) {
            _new_x386 = _left384;
            /* replace __x with _new_x386 in _parent383 */
            if (!((_parent383) == null)) {
                if (((_parent383)._left7) == (__x)) {
                    (_parent383)._left7 = _new_x386;
                } else {
                    (_parent383)._right8 = _new_x386;
                }
            }
            if (!((_new_x386) == null)) {
                (_new_x386)._parent9 = _parent383;
            }
        } else if (((_left384) == null) && (!((_right385) == null))) {
            _new_x386 = _right385;
            /* replace __x with _new_x386 in _parent383 */
            if (!((_parent383) == null)) {
                if (((_parent383)._left7) == (__x)) {
                    (_parent383)._left7 = _new_x386;
                } else {
                    (_parent383)._right8 = _new_x386;
                }
            }
            if (!((_new_x386) == null)) {
                (_new_x386)._parent9 = _parent383;
            }
        } else {
            var _root387 = (__x)._right8;
            var _x388 = _root387;
            var _descend389 = true;
            var _from_left390 = true;
            while (true) {
                if ((_x388) == null) {
                    _x388 = null;
                    break;
                }
                if (_descend389) {
                    /* too small? */
                    if (false) {
                        if ((!(((_x388)._right8) == null)) && (true)) {
                            if ((_x388) == (_root387)) {
                                _root387 = (_x388)._right8;
                            }
                            _x388 = (_x388)._right8;
                        } else if ((_x388) == (_root387)) {
                            _x388 = null;
                            break;
                        } else {
                            _descend389 = false;
                            _from_left390 = (!(((_x388)._parent9) == null)) && ((_x388) == (((_x388)._parent9)._left7));
                            _x388 = (_x388)._parent9;
                        }
                    } else if ((!(((_x388)._left7) == null)) && (true)) {
                        _x388 = (_x388)._left7;
                        /* too large? */
                    } else if (false) {
                        if ((_x388) == (_root387)) {
                            _x388 = null;
                            break;
                        } else {
                            _descend389 = false;
                            _from_left390 = (!(((_x388)._parent9) == null)) && ((_x388) == (((_x388)._parent9)._left7));
                            _x388 = (_x388)._parent9;
                        }
                        /* node ok? */
                    } else if (true) {
                        break;
                    } else if ((_x388) == (_root387)) {
                        _root387 = (_x388)._right8;
                        _x388 = (_x388)._right8;
                    } else {
                        if ((!(((_x388)._right8) == null)) && (true)) {
                            if ((_x388) == (_root387)) {
                                _root387 = (_x388)._right8;
                            }
                            _x388 = (_x388)._right8;
                        } else {
                            _descend389 = false;
                            _from_left390 = (!(((_x388)._parent9) == null)) && ((_x388) == (((_x388)._parent9)._left7));
                            _x388 = (_x388)._parent9;
                        }
                    }
                } else if (_from_left390) {
                    if (false) {
                        _x388 = null;
                        break;
                    } else if (true) {
                        break;
                    } else if ((!(((_x388)._right8) == null)) && (true)) {
                        _descend389 = true;
                        if ((_x388) == (_root387)) {
                            _root387 = (_x388)._right8;
                        }
                        _x388 = (_x388)._right8;
                    } else if ((_x388) == (_root387)) {
                        _x388 = null;
                        break;
                    } else {
                        _descend389 = false;
                        _from_left390 = (!(((_x388)._parent9) == null)) && ((_x388) == (((_x388)._parent9)._left7));
                        _x388 = (_x388)._parent9;
                    }
                } else {
                    if ((_x388) == (_root387)) {
                        _x388 = null;
                        break;
                    } else {
                        _descend389 = false;
                        _from_left390 = (!(((_x388)._parent9) == null)) && ((_x388) == (((_x388)._parent9)._left7));
                        _x388 = (_x388)._parent9;
                    }
                }
            }
            _new_x386 = _x388;
            var _mp391 = (_x388)._parent9;
            var _mr392 = (_x388)._right8;
            /* replace _x388 with _mr392 in _mp391 */
            if (!((_mp391) == null)) {
                if (((_mp391)._left7) == (_x388)) {
                    (_mp391)._left7 = _mr392;
                } else {
                    (_mp391)._right8 = _mr392;
                }
            }
            if (!((_mr392) == null)) {
                (_mr392)._parent9 = _mp391;
            }
            /* replace __x with _x388 in _parent383 */
            if (!((_parent383) == null)) {
                if (((_parent383)._left7) == (__x)) {
                    (_parent383)._left7 = _x388;
                } else {
                    (_parent383)._right8 = _x388;
                }
            }
            if (!((_x388) == null)) {
                (_x388)._parent9 = _parent383;
            }
            /* replace null with _left384 in _x388 */
            (_x388)._left7 = _left384;
            if (!((_left384) == null)) {
                (_left384)._parent9 = _x388;
            }
            /* replace _mr392 with (__x)._right8 in _x388 */
            (_x388)._right8 = (__x)._right8;
            if (!(((__x)._right8) == null)) {
                ((__x)._right8)._parent9 = _x388;
            }
            /* _min_ax12 is min of ax1 */
            var _augval393 = (_x388).ax1;
            var _child394 = (_x388)._left7;
            if (!((_child394) == null)) {
                var _val395 = (_child394)._min_ax12;
                _augval393 = ((_augval393) < (_val395)) ? (_augval393) : (_val395);
            }
            var _child396 = (_x388)._right8;
            if (!((_child396) == null)) {
                var _val397 = (_child396)._min_ax12;
                _augval393 = ((_augval393) < (_val397)) ? (_augval393) : (_val397);
            }
            (_x388)._min_ax12 = _augval393;
            /* _min_ay13 is min of ay1 */
            var _augval398 = (_x388).ay1;
            var _child399 = (_x388)._left7;
            if (!((_child399) == null)) {
                var _val400 = (_child399)._min_ay13;
                _augval398 = ((_augval398) < (_val400)) ? (_augval398) : (_val400);
            }
            var _child401 = (_x388)._right8;
            if (!((_child401) == null)) {
                var _val402 = (_child401)._min_ay13;
                _augval398 = ((_augval398) < (_val402)) ? (_augval398) : (_val402);
            }
            (_x388)._min_ay13 = _augval398;
            /* _max_ay24 is max of ay2 */
            var _augval403 = (_x388).ay2;
            var _child404 = (_x388)._left7;
            if (!((_child404) == null)) {
                var _val405 = (_child404)._max_ay24;
                _augval403 = ((_augval403) < (_val405)) ? (_val405) : (_augval403);
            }
            var _child406 = (_x388)._right8;
            if (!((_child406) == null)) {
                var _val407 = (_child406)._max_ay24;
                _augval403 = ((_augval403) < (_val407)) ? (_val407) : (_augval403);
            }
            (_x388)._max_ay24 = _augval403;
            (_x388)._height10 = 1 + ((((((_x388)._left7) == null) ? (-1) : (((_x388)._left7)._height10)) > ((((_x388)._right8) == null) ? (-1) : (((_x388)._right8)._height10))) ? ((((_x388)._left7) == null) ? (-1) : (((_x388)._left7)._height10)) : ((((_x388)._right8) == null) ? (-1) : (((_x388)._right8)._height10)));
            var _cursor408 = _mp391;
            var _changed409 = true;
            while ((_changed409) && (!((_cursor408) == (_parent383)))) {
                var _old__min_ax12410 = (_cursor408)._min_ax12;
                var _old__min_ay13411 = (_cursor408)._min_ay13;
                var _old__max_ay24412 = (_cursor408)._max_ay24;
                var _old_height413 = (_cursor408)._height10;
                /* _min_ax12 is min of ax1 */
                var _augval414 = (_cursor408).ax1;
                var _child415 = (_cursor408)._left7;
                if (!((_child415) == null)) {
                    var _val416 = (_child415)._min_ax12;
                    _augval414 = ((_augval414) < (_val416)) ? (_augval414) : (_val416);
                }
                var _child417 = (_cursor408)._right8;
                if (!((_child417) == null)) {
                    var _val418 = (_child417)._min_ax12;
                    _augval414 = ((_augval414) < (_val418)) ? (_augval414) : (_val418);
                }
                (_cursor408)._min_ax12 = _augval414;
                /* _min_ay13 is min of ay1 */
                var _augval419 = (_cursor408).ay1;
                var _child420 = (_cursor408)._left7;
                if (!((_child420) == null)) {
                    var _val421 = (_child420)._min_ay13;
                    _augval419 = ((_augval419) < (_val421)) ? (_augval419) : (_val421);
                }
                var _child422 = (_cursor408)._right8;
                if (!((_child422) == null)) {
                    var _val423 = (_child422)._min_ay13;
                    _augval419 = ((_augval419) < (_val423)) ? (_augval419) : (_val423);
                }
                (_cursor408)._min_ay13 = _augval419;
                /* _max_ay24 is max of ay2 */
                var _augval424 = (_cursor408).ay2;
                var _child425 = (_cursor408)._left7;
                if (!((_child425) == null)) {
                    var _val426 = (_child425)._max_ay24;
                    _augval424 = ((_augval424) < (_val426)) ? (_val426) : (_augval424);
                }
                var _child427 = (_cursor408)._right8;
                if (!((_child427) == null)) {
                    var _val428 = (_child427)._max_ay24;
                    _augval424 = ((_augval424) < (_val428)) ? (_val428) : (_augval424);
                }
                (_cursor408)._max_ay24 = _augval424;
                (_cursor408)._height10 = 1 + ((((((_cursor408)._left7) == null) ? (-1) : (((_cursor408)._left7)._height10)) > ((((_cursor408)._right8) == null) ? (-1) : (((_cursor408)._right8)._height10))) ? ((((_cursor408)._left7) == null) ? (-1) : (((_cursor408)._left7)._height10)) : ((((_cursor408)._right8) == null) ? (-1) : (((_cursor408)._right8)._height10)));
                _changed409 = false;
                _changed409 = (_changed409) || (!((_old__min_ax12410) == ((_cursor408)._min_ax12)));
                _changed409 = (_changed409) || (!((_old__min_ay13411) == ((_cursor408)._min_ay13)));
                _changed409 = (_changed409) || (!((_old__max_ay24412) == ((_cursor408)._max_ay24)));
                _changed409 = (_changed409) || (!((_old_height413) == ((_cursor408)._height10)));
                _cursor408 = (_cursor408)._parent9;
            }
        }
        var _cursor429 = _parent383;
        var _changed430 = true;
        while ((_changed430) && (!((_cursor429) == (null)))) {
            var _old__min_ax12431 = (_cursor429)._min_ax12;
            var _old__min_ay13432 = (_cursor429)._min_ay13;
            var _old__max_ay24433 = (_cursor429)._max_ay24;
            var _old_height434 = (_cursor429)._height10;
            /* _min_ax12 is min of ax1 */
            var _augval435 = (_cursor429).ax1;
            var _child436 = (_cursor429)._left7;
            if (!((_child436) == null)) {
                var _val437 = (_child436)._min_ax12;
                _augval435 = ((_augval435) < (_val437)) ? (_augval435) : (_val437);
            }
            var _child438 = (_cursor429)._right8;
            if (!((_child438) == null)) {
                var _val439 = (_child438)._min_ax12;
                _augval435 = ((_augval435) < (_val439)) ? (_augval435) : (_val439);
            }
            (_cursor429)._min_ax12 = _augval435;
            /* _min_ay13 is min of ay1 */
            var _augval440 = (_cursor429).ay1;
            var _child441 = (_cursor429)._left7;
            if (!((_child441) == null)) {
                var _val442 = (_child441)._min_ay13;
                _augval440 = ((_augval440) < (_val442)) ? (_augval440) : (_val442);
            }
            var _child443 = (_cursor429)._right8;
            if (!((_child443) == null)) {
                var _val444 = (_child443)._min_ay13;
                _augval440 = ((_augval440) < (_val444)) ? (_augval440) : (_val444);
            }
            (_cursor429)._min_ay13 = _augval440;
            /* _max_ay24 is max of ay2 */
            var _augval445 = (_cursor429).ay2;
            var _child446 = (_cursor429)._left7;
            if (!((_child446) == null)) {
                var _val447 = (_child446)._max_ay24;
                _augval445 = ((_augval445) < (_val447)) ? (_val447) : (_augval445);
            }
            var _child448 = (_cursor429)._right8;
            if (!((_child448) == null)) {
                var _val449 = (_child448)._max_ay24;
                _augval445 = ((_augval445) < (_val449)) ? (_val449) : (_augval445);
            }
            (_cursor429)._max_ay24 = _augval445;
            (_cursor429)._height10 = 1 + ((((((_cursor429)._left7) == null) ? (-1) : (((_cursor429)._left7)._height10)) > ((((_cursor429)._right8) == null) ? (-1) : (((_cursor429)._right8)._height10))) ? ((((_cursor429)._left7) == null) ? (-1) : (((_cursor429)._left7)._height10)) : ((((_cursor429)._right8) == null) ? (-1) : (((_cursor429)._right8)._height10)));
            _changed430 = false;
            _changed430 = (_changed430) || (!((_old__min_ax12431) == ((_cursor429)._min_ax12)));
            _changed430 = (_changed430) || (!((_old__min_ay13432) == ((_cursor429)._min_ay13)));
            _changed430 = (_changed430) || (!((_old__max_ay24433) == ((_cursor429)._max_ay24)));
            _changed430 = (_changed430) || (!((_old_height434) == ((_cursor429)._height10)));
            _cursor429 = (_cursor429)._parent9;
        }
        if (((this)._root1) == (__x)) {
            (this)._root1 = _new_x386;
        }
        (__x)._left7 = null;
        (__x)._right8 = null;
        (__x)._min_ax12 = (__x).ax1;
        (__x)._min_ay13 = (__x).ay1;
        (__x)._max_ay24 = (__x).ay2;
        (__x)._height10 = 0;
        var _previous450 = null;
        var _current451 = (this)._root1;
        var _is_left452 = false;
        while (!((_current451) == null)) {
            _previous450 = _current451;
            if ((new_val) < ((_current451).ax2)) {
                _current451 = (_current451)._left7;
                _is_left452 = true;
            } else {
                _current451 = (_current451)._right8;
                _is_left452 = false;
            }
        }
        if ((_previous450) == null) {
            (this)._root1 = __x;
        } else {
            (__x)._parent9 = _previous450;
            if (_is_left452) {
                (_previous450)._left7 = __x;
            } else {
                (_previous450)._right8 = __x;
            }
        }
        var _cursor453 = (__x)._parent9;
        var _changed454 = true;
        while ((_changed454) && (!((_cursor453) == (null)))) {
            var _old__min_ax12455 = (_cursor453)._min_ax12;
            var _old__min_ay13456 = (_cursor453)._min_ay13;
            var _old__max_ay24457 = (_cursor453)._max_ay24;
            var _old_height458 = (_cursor453)._height10;
            /* _min_ax12 is min of ax1 */
            var _augval459 = (_cursor453).ax1;
            var _child460 = (_cursor453)._left7;
            if (!((_child460) == null)) {
                var _val461 = (_child460)._min_ax12;
                _augval459 = ((_augval459) < (_val461)) ? (_augval459) : (_val461);
            }
            var _child462 = (_cursor453)._right8;
            if (!((_child462) == null)) {
                var _val463 = (_child462)._min_ax12;
                _augval459 = ((_augval459) < (_val463)) ? (_augval459) : (_val463);
            }
            (_cursor453)._min_ax12 = _augval459;
            /* _min_ay13 is min of ay1 */
            var _augval464 = (_cursor453).ay1;
            var _child465 = (_cursor453)._left7;
            if (!((_child465) == null)) {
                var _val466 = (_child465)._min_ay13;
                _augval464 = ((_augval464) < (_val466)) ? (_augval464) : (_val466);
            }
            var _child467 = (_cursor453)._right8;
            if (!((_child467) == null)) {
                var _val468 = (_child467)._min_ay13;
                _augval464 = ((_augval464) < (_val468)) ? (_augval464) : (_val468);
            }
            (_cursor453)._min_ay13 = _augval464;
            /* _max_ay24 is max of ay2 */
            var _augval469 = (_cursor453).ay2;
            var _child470 = (_cursor453)._left7;
            if (!((_child470) == null)) {
                var _val471 = (_child470)._max_ay24;
                _augval469 = ((_augval469) < (_val471)) ? (_val471) : (_augval469);
            }
            var _child472 = (_cursor453)._right8;
            if (!((_child472) == null)) {
                var _val473 = (_child472)._max_ay24;
                _augval469 = ((_augval469) < (_val473)) ? (_val473) : (_augval469);
            }
            (_cursor453)._max_ay24 = _augval469;
            (_cursor453)._height10 = 1 + ((((((_cursor453)._left7) == null) ? (-1) : (((_cursor453)._left7)._height10)) > ((((_cursor453)._right8) == null) ? (-1) : (((_cursor453)._right8)._height10))) ? ((((_cursor453)._left7) == null) ? (-1) : (((_cursor453)._left7)._height10)) : ((((_cursor453)._right8) == null) ? (-1) : (((_cursor453)._right8)._height10)));
            _changed454 = false;
            _changed454 = (_changed454) || (!((_old__min_ax12455) == ((_cursor453)._min_ax12)));
            _changed454 = (_changed454) || (!((_old__min_ay13456) == ((_cursor453)._min_ay13)));
            _changed454 = (_changed454) || (!((_old__max_ay24457) == ((_cursor453)._max_ay24)));
            _changed454 = (_changed454) || (!((_old_height458) == ((_cursor453)._height10)));
            _cursor453 = (_cursor453)._parent9;
        }
        /* rebalance AVL tree */
        var _cursor474 = __x;
        var _imbalance475;
        while (!(((_cursor474)._parent9) == null)) {
            _cursor474 = (_cursor474)._parent9;
            (_cursor474)._height10 = 1 + ((((((_cursor474)._left7) == null) ? (-1) : (((_cursor474)._left7)._height10)) > ((((_cursor474)._right8) == null) ? (-1) : (((_cursor474)._right8)._height10))) ? ((((_cursor474)._left7) == null) ? (-1) : (((_cursor474)._left7)._height10)) : ((((_cursor474)._right8) == null) ? (-1) : (((_cursor474)._right8)._height10)));
            _imbalance475 = ((((_cursor474)._left7) == null) ? (-1) : (((_cursor474)._left7)._height10)) - ((((_cursor474)._right8) == null) ? (-1) : (((_cursor474)._right8)._height10));
            if ((_imbalance475) > (1)) {
                if ((((((_cursor474)._left7)._left7) == null) ? (-1) : ((((_cursor474)._left7)._left7)._height10)) < (((((_cursor474)._left7)._right8) == null) ? (-1) : ((((_cursor474)._left7)._right8)._height10))) {
                    /* rotate ((_cursor474)._left7)._right8 */
                    var _a476 = (_cursor474)._left7;
                    var _b477 = (_a476)._right8;
                    var _c478 = (_b477)._left7;
                    /* replace _a476 with _b477 in (_a476)._parent9 */
                    if (!(((_a476)._parent9) == null)) {
                        if ((((_a476)._parent9)._left7) == (_a476)) {
                            ((_a476)._parent9)._left7 = _b477;
                        } else {
                            ((_a476)._parent9)._right8 = _b477;
                        }
                    }
                    if (!((_b477) == null)) {
                        (_b477)._parent9 = (_a476)._parent9;
                    }
                    /* replace _c478 with _a476 in _b477 */
                    (_b477)._left7 = _a476;
                    if (!((_a476) == null)) {
                        (_a476)._parent9 = _b477;
                    }
                    /* replace _b477 with _c478 in _a476 */
                    (_a476)._right8 = _c478;
                    if (!((_c478) == null)) {
                        (_c478)._parent9 = _a476;
                    }
                    /* _min_ax12 is min of ax1 */
                    var _augval479 = (_a476).ax1;
                    var _child480 = (_a476)._left7;
                    if (!((_child480) == null)) {
                        var _val481 = (_child480)._min_ax12;
                        _augval479 = ((_augval479) < (_val481)) ? (_augval479) : (_val481);
                    }
                    var _child482 = (_a476)._right8;
                    if (!((_child482) == null)) {
                        var _val483 = (_child482)._min_ax12;
                        _augval479 = ((_augval479) < (_val483)) ? (_augval479) : (_val483);
                    }
                    (_a476)._min_ax12 = _augval479;
                    /* _min_ay13 is min of ay1 */
                    var _augval484 = (_a476).ay1;
                    var _child485 = (_a476)._left7;
                    if (!((_child485) == null)) {
                        var _val486 = (_child485)._min_ay13;
                        _augval484 = ((_augval484) < (_val486)) ? (_augval484) : (_val486);
                    }
                    var _child487 = (_a476)._right8;
                    if (!((_child487) == null)) {
                        var _val488 = (_child487)._min_ay13;
                        _augval484 = ((_augval484) < (_val488)) ? (_augval484) : (_val488);
                    }
                    (_a476)._min_ay13 = _augval484;
                    /* _max_ay24 is max of ay2 */
                    var _augval489 = (_a476).ay2;
                    var _child490 = (_a476)._left7;
                    if (!((_child490) == null)) {
                        var _val491 = (_child490)._max_ay24;
                        _augval489 = ((_augval489) < (_val491)) ? (_val491) : (_augval489);
                    }
                    var _child492 = (_a476)._right8;
                    if (!((_child492) == null)) {
                        var _val493 = (_child492)._max_ay24;
                        _augval489 = ((_augval489) < (_val493)) ? (_val493) : (_augval489);
                    }
                    (_a476)._max_ay24 = _augval489;
                    (_a476)._height10 = 1 + ((((((_a476)._left7) == null) ? (-1) : (((_a476)._left7)._height10)) > ((((_a476)._right8) == null) ? (-1) : (((_a476)._right8)._height10))) ? ((((_a476)._left7) == null) ? (-1) : (((_a476)._left7)._height10)) : ((((_a476)._right8) == null) ? (-1) : (((_a476)._right8)._height10)));
                    /* _min_ax12 is min of ax1 */
                    var _augval494 = (_b477).ax1;
                    var _child495 = (_b477)._left7;
                    if (!((_child495) == null)) {
                        var _val496 = (_child495)._min_ax12;
                        _augval494 = ((_augval494) < (_val496)) ? (_augval494) : (_val496);
                    }
                    var _child497 = (_b477)._right8;
                    if (!((_child497) == null)) {
                        var _val498 = (_child497)._min_ax12;
                        _augval494 = ((_augval494) < (_val498)) ? (_augval494) : (_val498);
                    }
                    (_b477)._min_ax12 = _augval494;
                    /* _min_ay13 is min of ay1 */
                    var _augval499 = (_b477).ay1;
                    var _child500 = (_b477)._left7;
                    if (!((_child500) == null)) {
                        var _val501 = (_child500)._min_ay13;
                        _augval499 = ((_augval499) < (_val501)) ? (_augval499) : (_val501);
                    }
                    var _child502 = (_b477)._right8;
                    if (!((_child502) == null)) {
                        var _val503 = (_child502)._min_ay13;
                        _augval499 = ((_augval499) < (_val503)) ? (_augval499) : (_val503);
                    }
                    (_b477)._min_ay13 = _augval499;
                    /* _max_ay24 is max of ay2 */
                    var _augval504 = (_b477).ay2;
                    var _child505 = (_b477)._left7;
                    if (!((_child505) == null)) {
                        var _val506 = (_child505)._max_ay24;
                        _augval504 = ((_augval504) < (_val506)) ? (_val506) : (_augval504);
                    }
                    var _child507 = (_b477)._right8;
                    if (!((_child507) == null)) {
                        var _val508 = (_child507)._max_ay24;
                        _augval504 = ((_augval504) < (_val508)) ? (_val508) : (_augval504);
                    }
                    (_b477)._max_ay24 = _augval504;
                    (_b477)._height10 = 1 + ((((((_b477)._left7) == null) ? (-1) : (((_b477)._left7)._height10)) > ((((_b477)._right8) == null) ? (-1) : (((_b477)._right8)._height10))) ? ((((_b477)._left7) == null) ? (-1) : (((_b477)._left7)._height10)) : ((((_b477)._right8) == null) ? (-1) : (((_b477)._right8)._height10)));
                    if (!(((_b477)._parent9) == null)) {
                        /* _min_ax12 is min of ax1 */
                        var _augval509 = ((_b477)._parent9).ax1;
                        var _child510 = ((_b477)._parent9)._left7;
                        if (!((_child510) == null)) {
                            var _val511 = (_child510)._min_ax12;
                            _augval509 = ((_augval509) < (_val511)) ? (_augval509) : (_val511);
                        }
                        var _child512 = ((_b477)._parent9)._right8;
                        if (!((_child512) == null)) {
                            var _val513 = (_child512)._min_ax12;
                            _augval509 = ((_augval509) < (_val513)) ? (_augval509) : (_val513);
                        }
                        ((_b477)._parent9)._min_ax12 = _augval509;
                        /* _min_ay13 is min of ay1 */
                        var _augval514 = ((_b477)._parent9).ay1;
                        var _child515 = ((_b477)._parent9)._left7;
                        if (!((_child515) == null)) {
                            var _val516 = (_child515)._min_ay13;
                            _augval514 = ((_augval514) < (_val516)) ? (_augval514) : (_val516);
                        }
                        var _child517 = ((_b477)._parent9)._right8;
                        if (!((_child517) == null)) {
                            var _val518 = (_child517)._min_ay13;
                            _augval514 = ((_augval514) < (_val518)) ? (_augval514) : (_val518);
                        }
                        ((_b477)._parent9)._min_ay13 = _augval514;
                        /* _max_ay24 is max of ay2 */
                        var _augval519 = ((_b477)._parent9).ay2;
                        var _child520 = ((_b477)._parent9)._left7;
                        if (!((_child520) == null)) {
                            var _val521 = (_child520)._max_ay24;
                            _augval519 = ((_augval519) < (_val521)) ? (_val521) : (_augval519);
                        }
                        var _child522 = ((_b477)._parent9)._right8;
                        if (!((_child522) == null)) {
                            var _val523 = (_child522)._max_ay24;
                            _augval519 = ((_augval519) < (_val523)) ? (_val523) : (_augval519);
                        }
                        ((_b477)._parent9)._max_ay24 = _augval519;
                        ((_b477)._parent9)._height10 = 1 + (((((((_b477)._parent9)._left7) == null) ? (-1) : ((((_b477)._parent9)._left7)._height10)) > (((((_b477)._parent9)._right8) == null) ? (-1) : ((((_b477)._parent9)._right8)._height10))) ? (((((_b477)._parent9)._left7) == null) ? (-1) : ((((_b477)._parent9)._left7)._height10)) : (((((_b477)._parent9)._right8) == null) ? (-1) : ((((_b477)._parent9)._right8)._height10)));
                    } else {
                        (this)._root1 = _b477;
                    }
                }
                /* rotate (_cursor474)._left7 */
                var _a524 = _cursor474;
                var _b525 = (_a524)._left7;
                var _c526 = (_b525)._right8;
                /* replace _a524 with _b525 in (_a524)._parent9 */
                if (!(((_a524)._parent9) == null)) {
                    if ((((_a524)._parent9)._left7) == (_a524)) {
                        ((_a524)._parent9)._left7 = _b525;
                    } else {
                        ((_a524)._parent9)._right8 = _b525;
                    }
                }
                if (!((_b525) == null)) {
                    (_b525)._parent9 = (_a524)._parent9;
                }
                /* replace _c526 with _a524 in _b525 */
                (_b525)._right8 = _a524;
                if (!((_a524) == null)) {
                    (_a524)._parent9 = _b525;
                }
                /* replace _b525 with _c526 in _a524 */
                (_a524)._left7 = _c526;
                if (!((_c526) == null)) {
                    (_c526)._parent9 = _a524;
                }
                /* _min_ax12 is min of ax1 */
                var _augval527 = (_a524).ax1;
                var _child528 = (_a524)._left7;
                if (!((_child528) == null)) {
                    var _val529 = (_child528)._min_ax12;
                    _augval527 = ((_augval527) < (_val529)) ? (_augval527) : (_val529);
                }
                var _child530 = (_a524)._right8;
                if (!((_child530) == null)) {
                    var _val531 = (_child530)._min_ax12;
                    _augval527 = ((_augval527) < (_val531)) ? (_augval527) : (_val531);
                }
                (_a524)._min_ax12 = _augval527;
                /* _min_ay13 is min of ay1 */
                var _augval532 = (_a524).ay1;
                var _child533 = (_a524)._left7;
                if (!((_child533) == null)) {
                    var _val534 = (_child533)._min_ay13;
                    _augval532 = ((_augval532) < (_val534)) ? (_augval532) : (_val534);
                }
                var _child535 = (_a524)._right8;
                if (!((_child535) == null)) {
                    var _val536 = (_child535)._min_ay13;
                    _augval532 = ((_augval532) < (_val536)) ? (_augval532) : (_val536);
                }
                (_a524)._min_ay13 = _augval532;
                /* _max_ay24 is max of ay2 */
                var _augval537 = (_a524).ay2;
                var _child538 = (_a524)._left7;
                if (!((_child538) == null)) {
                    var _val539 = (_child538)._max_ay24;
                    _augval537 = ((_augval537) < (_val539)) ? (_val539) : (_augval537);
                }
                var _child540 = (_a524)._right8;
                if (!((_child540) == null)) {
                    var _val541 = (_child540)._max_ay24;
                    _augval537 = ((_augval537) < (_val541)) ? (_val541) : (_augval537);
                }
                (_a524)._max_ay24 = _augval537;
                (_a524)._height10 = 1 + ((((((_a524)._left7) == null) ? (-1) : (((_a524)._left7)._height10)) > ((((_a524)._right8) == null) ? (-1) : (((_a524)._right8)._height10))) ? ((((_a524)._left7) == null) ? (-1) : (((_a524)._left7)._height10)) : ((((_a524)._right8) == null) ? (-1) : (((_a524)._right8)._height10)));
                /* _min_ax12 is min of ax1 */
                var _augval542 = (_b525).ax1;
                var _child543 = (_b525)._left7;
                if (!((_child543) == null)) {
                    var _val544 = (_child543)._min_ax12;
                    _augval542 = ((_augval542) < (_val544)) ? (_augval542) : (_val544);
                }
                var _child545 = (_b525)._right8;
                if (!((_child545) == null)) {
                    var _val546 = (_child545)._min_ax12;
                    _augval542 = ((_augval542) < (_val546)) ? (_augval542) : (_val546);
                }
                (_b525)._min_ax12 = _augval542;
                /* _min_ay13 is min of ay1 */
                var _augval547 = (_b525).ay1;
                var _child548 = (_b525)._left7;
                if (!((_child548) == null)) {
                    var _val549 = (_child548)._min_ay13;
                    _augval547 = ((_augval547) < (_val549)) ? (_augval547) : (_val549);
                }
                var _child550 = (_b525)._right8;
                if (!((_child550) == null)) {
                    var _val551 = (_child550)._min_ay13;
                    _augval547 = ((_augval547) < (_val551)) ? (_augval547) : (_val551);
                }
                (_b525)._min_ay13 = _augval547;
                /* _max_ay24 is max of ay2 */
                var _augval552 = (_b525).ay2;
                var _child553 = (_b525)._left7;
                if (!((_child553) == null)) {
                    var _val554 = (_child553)._max_ay24;
                    _augval552 = ((_augval552) < (_val554)) ? (_val554) : (_augval552);
                }
                var _child555 = (_b525)._right8;
                if (!((_child555) == null)) {
                    var _val556 = (_child555)._max_ay24;
                    _augval552 = ((_augval552) < (_val556)) ? (_val556) : (_augval552);
                }
                (_b525)._max_ay24 = _augval552;
                (_b525)._height10 = 1 + ((((((_b525)._left7) == null) ? (-1) : (((_b525)._left7)._height10)) > ((((_b525)._right8) == null) ? (-1) : (((_b525)._right8)._height10))) ? ((((_b525)._left7) == null) ? (-1) : (((_b525)._left7)._height10)) : ((((_b525)._right8) == null) ? (-1) : (((_b525)._right8)._height10)));
                if (!(((_b525)._parent9) == null)) {
                    /* _min_ax12 is min of ax1 */
                    var _augval557 = ((_b525)._parent9).ax1;
                    var _child558 = ((_b525)._parent9)._left7;
                    if (!((_child558) == null)) {
                        var _val559 = (_child558)._min_ax12;
                        _augval557 = ((_augval557) < (_val559)) ? (_augval557) : (_val559);
                    }
                    var _child560 = ((_b525)._parent9)._right8;
                    if (!((_child560) == null)) {
                        var _val561 = (_child560)._min_ax12;
                        _augval557 = ((_augval557) < (_val561)) ? (_augval557) : (_val561);
                    }
                    ((_b525)._parent9)._min_ax12 = _augval557;
                    /* _min_ay13 is min of ay1 */
                    var _augval562 = ((_b525)._parent9).ay1;
                    var _child563 = ((_b525)._parent9)._left7;
                    if (!((_child563) == null)) {
                        var _val564 = (_child563)._min_ay13;
                        _augval562 = ((_augval562) < (_val564)) ? (_augval562) : (_val564);
                    }
                    var _child565 = ((_b525)._parent9)._right8;
                    if (!((_child565) == null)) {
                        var _val566 = (_child565)._min_ay13;
                        _augval562 = ((_augval562) < (_val566)) ? (_augval562) : (_val566);
                    }
                    ((_b525)._parent9)._min_ay13 = _augval562;
                    /* _max_ay24 is max of ay2 */
                    var _augval567 = ((_b525)._parent9).ay2;
                    var _child568 = ((_b525)._parent9)._left7;
                    if (!((_child568) == null)) {
                        var _val569 = (_child568)._max_ay24;
                        _augval567 = ((_augval567) < (_val569)) ? (_val569) : (_augval567);
                    }
                    var _child570 = ((_b525)._parent9)._right8;
                    if (!((_child570) == null)) {
                        var _val571 = (_child570)._max_ay24;
                        _augval567 = ((_augval567) < (_val571)) ? (_val571) : (_augval567);
                    }
                    ((_b525)._parent9)._max_ay24 = _augval567;
                    ((_b525)._parent9)._height10 = 1 + (((((((_b525)._parent9)._left7) == null) ? (-1) : ((((_b525)._parent9)._left7)._height10)) > (((((_b525)._parent9)._right8) == null) ? (-1) : ((((_b525)._parent9)._right8)._height10))) ? (((((_b525)._parent9)._left7) == null) ? (-1) : ((((_b525)._parent9)._left7)._height10)) : (((((_b525)._parent9)._right8) == null) ? (-1) : ((((_b525)._parent9)._right8)._height10)));
                } else {
                    (this)._root1 = _b525;
                }
                _cursor474 = (_cursor474)._parent9;
            } else if ((_imbalance475) < (-1)) {
                if ((((((_cursor474)._right8)._left7) == null) ? (-1) : ((((_cursor474)._right8)._left7)._height10)) > (((((_cursor474)._right8)._right8) == null) ? (-1) : ((((_cursor474)._right8)._right8)._height10))) {
                    /* rotate ((_cursor474)._right8)._left7 */
                    var _a572 = (_cursor474)._right8;
                    var _b573 = (_a572)._left7;
                    var _c574 = (_b573)._right8;
                    /* replace _a572 with _b573 in (_a572)._parent9 */
                    if (!(((_a572)._parent9) == null)) {
                        if ((((_a572)._parent9)._left7) == (_a572)) {
                            ((_a572)._parent9)._left7 = _b573;
                        } else {
                            ((_a572)._parent9)._right8 = _b573;
                        }
                    }
                    if (!((_b573) == null)) {
                        (_b573)._parent9 = (_a572)._parent9;
                    }
                    /* replace _c574 with _a572 in _b573 */
                    (_b573)._right8 = _a572;
                    if (!((_a572) == null)) {
                        (_a572)._parent9 = _b573;
                    }
                    /* replace _b573 with _c574 in _a572 */
                    (_a572)._left7 = _c574;
                    if (!((_c574) == null)) {
                        (_c574)._parent9 = _a572;
                    }
                    /* _min_ax12 is min of ax1 */
                    var _augval575 = (_a572).ax1;
                    var _child576 = (_a572)._left7;
                    if (!((_child576) == null)) {
                        var _val577 = (_child576)._min_ax12;
                        _augval575 = ((_augval575) < (_val577)) ? (_augval575) : (_val577);
                    }
                    var _child578 = (_a572)._right8;
                    if (!((_child578) == null)) {
                        var _val579 = (_child578)._min_ax12;
                        _augval575 = ((_augval575) < (_val579)) ? (_augval575) : (_val579);
                    }
                    (_a572)._min_ax12 = _augval575;
                    /* _min_ay13 is min of ay1 */
                    var _augval580 = (_a572).ay1;
                    var _child581 = (_a572)._left7;
                    if (!((_child581) == null)) {
                        var _val582 = (_child581)._min_ay13;
                        _augval580 = ((_augval580) < (_val582)) ? (_augval580) : (_val582);
                    }
                    var _child583 = (_a572)._right8;
                    if (!((_child583) == null)) {
                        var _val584 = (_child583)._min_ay13;
                        _augval580 = ((_augval580) < (_val584)) ? (_augval580) : (_val584);
                    }
                    (_a572)._min_ay13 = _augval580;
                    /* _max_ay24 is max of ay2 */
                    var _augval585 = (_a572).ay2;
                    var _child586 = (_a572)._left7;
                    if (!((_child586) == null)) {
                        var _val587 = (_child586)._max_ay24;
                        _augval585 = ((_augval585) < (_val587)) ? (_val587) : (_augval585);
                    }
                    var _child588 = (_a572)._right8;
                    if (!((_child588) == null)) {
                        var _val589 = (_child588)._max_ay24;
                        _augval585 = ((_augval585) < (_val589)) ? (_val589) : (_augval585);
                    }
                    (_a572)._max_ay24 = _augval585;
                    (_a572)._height10 = 1 + ((((((_a572)._left7) == null) ? (-1) : (((_a572)._left7)._height10)) > ((((_a572)._right8) == null) ? (-1) : (((_a572)._right8)._height10))) ? ((((_a572)._left7) == null) ? (-1) : (((_a572)._left7)._height10)) : ((((_a572)._right8) == null) ? (-1) : (((_a572)._right8)._height10)));
                    /* _min_ax12 is min of ax1 */
                    var _augval590 = (_b573).ax1;
                    var _child591 = (_b573)._left7;
                    if (!((_child591) == null)) {
                        var _val592 = (_child591)._min_ax12;
                        _augval590 = ((_augval590) < (_val592)) ? (_augval590) : (_val592);
                    }
                    var _child593 = (_b573)._right8;
                    if (!((_child593) == null)) {
                        var _val594 = (_child593)._min_ax12;
                        _augval590 = ((_augval590) < (_val594)) ? (_augval590) : (_val594);
                    }
                    (_b573)._min_ax12 = _augval590;
                    /* _min_ay13 is min of ay1 */
                    var _augval595 = (_b573).ay1;
                    var _child596 = (_b573)._left7;
                    if (!((_child596) == null)) {
                        var _val597 = (_child596)._min_ay13;
                        _augval595 = ((_augval595) < (_val597)) ? (_augval595) : (_val597);
                    }
                    var _child598 = (_b573)._right8;
                    if (!((_child598) == null)) {
                        var _val599 = (_child598)._min_ay13;
                        _augval595 = ((_augval595) < (_val599)) ? (_augval595) : (_val599);
                    }
                    (_b573)._min_ay13 = _augval595;
                    /* _max_ay24 is max of ay2 */
                    var _augval600 = (_b573).ay2;
                    var _child601 = (_b573)._left7;
                    if (!((_child601) == null)) {
                        var _val602 = (_child601)._max_ay24;
                        _augval600 = ((_augval600) < (_val602)) ? (_val602) : (_augval600);
                    }
                    var _child603 = (_b573)._right8;
                    if (!((_child603) == null)) {
                        var _val604 = (_child603)._max_ay24;
                        _augval600 = ((_augval600) < (_val604)) ? (_val604) : (_augval600);
                    }
                    (_b573)._max_ay24 = _augval600;
                    (_b573)._height10 = 1 + ((((((_b573)._left7) == null) ? (-1) : (((_b573)._left7)._height10)) > ((((_b573)._right8) == null) ? (-1) : (((_b573)._right8)._height10))) ? ((((_b573)._left7) == null) ? (-1) : (((_b573)._left7)._height10)) : ((((_b573)._right8) == null) ? (-1) : (((_b573)._right8)._height10)));
                    if (!(((_b573)._parent9) == null)) {
                        /* _min_ax12 is min of ax1 */
                        var _augval605 = ((_b573)._parent9).ax1;
                        var _child606 = ((_b573)._parent9)._left7;
                        if (!((_child606) == null)) {
                            var _val607 = (_child606)._min_ax12;
                            _augval605 = ((_augval605) < (_val607)) ? (_augval605) : (_val607);
                        }
                        var _child608 = ((_b573)._parent9)._right8;
                        if (!((_child608) == null)) {
                            var _val609 = (_child608)._min_ax12;
                            _augval605 = ((_augval605) < (_val609)) ? (_augval605) : (_val609);
                        }
                        ((_b573)._parent9)._min_ax12 = _augval605;
                        /* _min_ay13 is min of ay1 */
                        var _augval610 = ((_b573)._parent9).ay1;
                        var _child611 = ((_b573)._parent9)._left7;
                        if (!((_child611) == null)) {
                            var _val612 = (_child611)._min_ay13;
                            _augval610 = ((_augval610) < (_val612)) ? (_augval610) : (_val612);
                        }
                        var _child613 = ((_b573)._parent9)._right8;
                        if (!((_child613) == null)) {
                            var _val614 = (_child613)._min_ay13;
                            _augval610 = ((_augval610) < (_val614)) ? (_augval610) : (_val614);
                        }
                        ((_b573)._parent9)._min_ay13 = _augval610;
                        /* _max_ay24 is max of ay2 */
                        var _augval615 = ((_b573)._parent9).ay2;
                        var _child616 = ((_b573)._parent9)._left7;
                        if (!((_child616) == null)) {
                            var _val617 = (_child616)._max_ay24;
                            _augval615 = ((_augval615) < (_val617)) ? (_val617) : (_augval615);
                        }
                        var _child618 = ((_b573)._parent9)._right8;
                        if (!((_child618) == null)) {
                            var _val619 = (_child618)._max_ay24;
                            _augval615 = ((_augval615) < (_val619)) ? (_val619) : (_augval615);
                        }
                        ((_b573)._parent9)._max_ay24 = _augval615;
                        ((_b573)._parent9)._height10 = 1 + (((((((_b573)._parent9)._left7) == null) ? (-1) : ((((_b573)._parent9)._left7)._height10)) > (((((_b573)._parent9)._right8) == null) ? (-1) : ((((_b573)._parent9)._right8)._height10))) ? (((((_b573)._parent9)._left7) == null) ? (-1) : ((((_b573)._parent9)._left7)._height10)) : (((((_b573)._parent9)._right8) == null) ? (-1) : ((((_b573)._parent9)._right8)._height10)));
                    } else {
                        (this)._root1 = _b573;
                    }
                }
                /* rotate (_cursor474)._right8 */
                var _a620 = _cursor474;
                var _b621 = (_a620)._right8;
                var _c622 = (_b621)._left7;
                /* replace _a620 with _b621 in (_a620)._parent9 */
                if (!(((_a620)._parent9) == null)) {
                    if ((((_a620)._parent9)._left7) == (_a620)) {
                        ((_a620)._parent9)._left7 = _b621;
                    } else {
                        ((_a620)._parent9)._right8 = _b621;
                    }
                }
                if (!((_b621) == null)) {
                    (_b621)._parent9 = (_a620)._parent9;
                }
                /* replace _c622 with _a620 in _b621 */
                (_b621)._left7 = _a620;
                if (!((_a620) == null)) {
                    (_a620)._parent9 = _b621;
                }
                /* replace _b621 with _c622 in _a620 */
                (_a620)._right8 = _c622;
                if (!((_c622) == null)) {
                    (_c622)._parent9 = _a620;
                }
                /* _min_ax12 is min of ax1 */
                var _augval623 = (_a620).ax1;
                var _child624 = (_a620)._left7;
                if (!((_child624) == null)) {
                    var _val625 = (_child624)._min_ax12;
                    _augval623 = ((_augval623) < (_val625)) ? (_augval623) : (_val625);
                }
                var _child626 = (_a620)._right8;
                if (!((_child626) == null)) {
                    var _val627 = (_child626)._min_ax12;
                    _augval623 = ((_augval623) < (_val627)) ? (_augval623) : (_val627);
                }
                (_a620)._min_ax12 = _augval623;
                /* _min_ay13 is min of ay1 */
                var _augval628 = (_a620).ay1;
                var _child629 = (_a620)._left7;
                if (!((_child629) == null)) {
                    var _val630 = (_child629)._min_ay13;
                    _augval628 = ((_augval628) < (_val630)) ? (_augval628) : (_val630);
                }
                var _child631 = (_a620)._right8;
                if (!((_child631) == null)) {
                    var _val632 = (_child631)._min_ay13;
                    _augval628 = ((_augval628) < (_val632)) ? (_augval628) : (_val632);
                }
                (_a620)._min_ay13 = _augval628;
                /* _max_ay24 is max of ay2 */
                var _augval633 = (_a620).ay2;
                var _child634 = (_a620)._left7;
                if (!((_child634) == null)) {
                    var _val635 = (_child634)._max_ay24;
                    _augval633 = ((_augval633) < (_val635)) ? (_val635) : (_augval633);
                }
                var _child636 = (_a620)._right8;
                if (!((_child636) == null)) {
                    var _val637 = (_child636)._max_ay24;
                    _augval633 = ((_augval633) < (_val637)) ? (_val637) : (_augval633);
                }
                (_a620)._max_ay24 = _augval633;
                (_a620)._height10 = 1 + ((((((_a620)._left7) == null) ? (-1) : (((_a620)._left7)._height10)) > ((((_a620)._right8) == null) ? (-1) : (((_a620)._right8)._height10))) ? ((((_a620)._left7) == null) ? (-1) : (((_a620)._left7)._height10)) : ((((_a620)._right8) == null) ? (-1) : (((_a620)._right8)._height10)));
                /* _min_ax12 is min of ax1 */
                var _augval638 = (_b621).ax1;
                var _child639 = (_b621)._left7;
                if (!((_child639) == null)) {
                    var _val640 = (_child639)._min_ax12;
                    _augval638 = ((_augval638) < (_val640)) ? (_augval638) : (_val640);
                }
                var _child641 = (_b621)._right8;
                if (!((_child641) == null)) {
                    var _val642 = (_child641)._min_ax12;
                    _augval638 = ((_augval638) < (_val642)) ? (_augval638) : (_val642);
                }
                (_b621)._min_ax12 = _augval638;
                /* _min_ay13 is min of ay1 */
                var _augval643 = (_b621).ay1;
                var _child644 = (_b621)._left7;
                if (!((_child644) == null)) {
                    var _val645 = (_child644)._min_ay13;
                    _augval643 = ((_augval643) < (_val645)) ? (_augval643) : (_val645);
                }
                var _child646 = (_b621)._right8;
                if (!((_child646) == null)) {
                    var _val647 = (_child646)._min_ay13;
                    _augval643 = ((_augval643) < (_val647)) ? (_augval643) : (_val647);
                }
                (_b621)._min_ay13 = _augval643;
                /* _max_ay24 is max of ay2 */
                var _augval648 = (_b621).ay2;
                var _child649 = (_b621)._left7;
                if (!((_child649) == null)) {
                    var _val650 = (_child649)._max_ay24;
                    _augval648 = ((_augval648) < (_val650)) ? (_val650) : (_augval648);
                }
                var _child651 = (_b621)._right8;
                if (!((_child651) == null)) {
                    var _val652 = (_child651)._max_ay24;
                    _augval648 = ((_augval648) < (_val652)) ? (_val652) : (_augval648);
                }
                (_b621)._max_ay24 = _augval648;
                (_b621)._height10 = 1 + ((((((_b621)._left7) == null) ? (-1) : (((_b621)._left7)._height10)) > ((((_b621)._right8) == null) ? (-1) : (((_b621)._right8)._height10))) ? ((((_b621)._left7) == null) ? (-1) : (((_b621)._left7)._height10)) : ((((_b621)._right8) == null) ? (-1) : (((_b621)._right8)._height10)));
                if (!(((_b621)._parent9) == null)) {
                    /* _min_ax12 is min of ax1 */
                    var _augval653 = ((_b621)._parent9).ax1;
                    var _child654 = ((_b621)._parent9)._left7;
                    if (!((_child654) == null)) {
                        var _val655 = (_child654)._min_ax12;
                        _augval653 = ((_augval653) < (_val655)) ? (_augval653) : (_val655);
                    }
                    var _child656 = ((_b621)._parent9)._right8;
                    if (!((_child656) == null)) {
                        var _val657 = (_child656)._min_ax12;
                        _augval653 = ((_augval653) < (_val657)) ? (_augval653) : (_val657);
                    }
                    ((_b621)._parent9)._min_ax12 = _augval653;
                    /* _min_ay13 is min of ay1 */
                    var _augval658 = ((_b621)._parent9).ay1;
                    var _child659 = ((_b621)._parent9)._left7;
                    if (!((_child659) == null)) {
                        var _val660 = (_child659)._min_ay13;
                        _augval658 = ((_augval658) < (_val660)) ? (_augval658) : (_val660);
                    }
                    var _child661 = ((_b621)._parent9)._right8;
                    if (!((_child661) == null)) {
                        var _val662 = (_child661)._min_ay13;
                        _augval658 = ((_augval658) < (_val662)) ? (_augval658) : (_val662);
                    }
                    ((_b621)._parent9)._min_ay13 = _augval658;
                    /* _max_ay24 is max of ay2 */
                    var _augval663 = ((_b621)._parent9).ay2;
                    var _child664 = ((_b621)._parent9)._left7;
                    if (!((_child664) == null)) {
                        var _val665 = (_child664)._max_ay24;
                        _augval663 = ((_augval663) < (_val665)) ? (_val665) : (_augval663);
                    }
                    var _child666 = ((_b621)._parent9)._right8;
                    if (!((_child666) == null)) {
                        var _val667 = (_child666)._max_ay24;
                        _augval663 = ((_augval663) < (_val667)) ? (_val667) : (_augval663);
                    }
                    ((_b621)._parent9)._max_ay24 = _augval663;
                    ((_b621)._parent9)._height10 = 1 + (((((((_b621)._parent9)._left7) == null) ? (-1) : ((((_b621)._parent9)._left7)._height10)) > (((((_b621)._parent9)._right8) == null) ? (-1) : ((((_b621)._parent9)._right8)._height10))) ? (((((_b621)._parent9)._left7) == null) ? (-1) : ((((_b621)._parent9)._left7)._height10)) : (((((_b621)._parent9)._right8) == null) ? (-1) : ((((_b621)._parent9)._right8)._height10)));
                } else {
                    (this)._root1 = _b621;
                }
                _cursor474 = (_cursor474)._parent9;
            }
        }
        (__x).ax2 = new_val;
    }
}
RectangleHolder.prototype.updateAy2 = function (__x, new_val) {
    if ((__x).ay2 != new_val) {
        /* _max_ay24 is max of ay2 */
        var _augval668 = new_val;
        var _child669 = (__x)._left7;
        if (!((_child669) == null)) {
            var _val670 = (_child669)._max_ay24;
            _augval668 = ((_augval668) < (_val670)) ? (_val670) : (_augval668);
        }
        var _child671 = (__x)._right8;
        if (!((_child671) == null)) {
            var _val672 = (_child671)._max_ay24;
            _augval668 = ((_augval668) < (_val672)) ? (_val672) : (_augval668);
        }
        (__x)._max_ay24 = _augval668;
        var _cursor673 = (__x)._parent9;
        var _changed674 = true;
        while ((_changed674) && (!((_cursor673) == (null)))) {
            var _old__max_ay24675 = (_cursor673)._max_ay24;
            var _old_height676 = (_cursor673)._height10;
            /* _max_ay24 is max of ay2 */
            var _augval677 = (_cursor673).ay2;
            var _child678 = (_cursor673)._left7;
            if (!((_child678) == null)) {
                var _val679 = (_child678)._max_ay24;
                _augval677 = ((_augval677) < (_val679)) ? (_val679) : (_augval677);
            }
            var _child680 = (_cursor673)._right8;
            if (!((_child680) == null)) {
                var _val681 = (_child680)._max_ay24;
                _augval677 = ((_augval677) < (_val681)) ? (_val681) : (_augval677);
            }
            (_cursor673)._max_ay24 = _augval677;
            (_cursor673)._height10 = 1 + ((((((_cursor673)._left7) == null) ? (-1) : (((_cursor673)._left7)._height10)) > ((((_cursor673)._right8) == null) ? (-1) : (((_cursor673)._right8)._height10))) ? ((((_cursor673)._left7) == null) ? (-1) : (((_cursor673)._left7)._height10)) : ((((_cursor673)._right8) == null) ? (-1) : (((_cursor673)._right8)._height10)));
            _changed674 = false;
            _changed674 = (_changed674) || (!((_old__max_ay24675) == ((_cursor673)._max_ay24)));
            _changed674 = (_changed674) || (!((_old_height676) == ((_cursor673)._height10)));
            _cursor673 = (_cursor673)._parent9;
        }
        (__x).ay2 = new_val;
    }
}
RectangleHolder.prototype.update = function (__x, ax1, ay1, ax2, ay2) {
    var _parent682 = (__x)._parent9;
    var _left683 = (__x)._left7;
    var _right684 = (__x)._right8;
    var _new_x685;
    if (((_left683) == null) && ((_right684) == null)) {
        _new_x685 = null;
        /* replace __x with _new_x685 in _parent682 */
        if (!((_parent682) == null)) {
            if (((_parent682)._left7) == (__x)) {
                (_parent682)._left7 = _new_x685;
            } else {
                (_parent682)._right8 = _new_x685;
            }
        }
        if (!((_new_x685) == null)) {
            (_new_x685)._parent9 = _parent682;
        }
    } else if ((!((_left683) == null)) && ((_right684) == null)) {
        _new_x685 = _left683;
        /* replace __x with _new_x685 in _parent682 */
        if (!((_parent682) == null)) {
            if (((_parent682)._left7) == (__x)) {
                (_parent682)._left7 = _new_x685;
            } else {
                (_parent682)._right8 = _new_x685;
            }
        }
        if (!((_new_x685) == null)) {
            (_new_x685)._parent9 = _parent682;
        }
    } else if (((_left683) == null) && (!((_right684) == null))) {
        _new_x685 = _right684;
        /* replace __x with _new_x685 in _parent682 */
        if (!((_parent682) == null)) {
            if (((_parent682)._left7) == (__x)) {
                (_parent682)._left7 = _new_x685;
            } else {
                (_parent682)._right8 = _new_x685;
            }
        }
        if (!((_new_x685) == null)) {
            (_new_x685)._parent9 = _parent682;
        }
    } else {
        var _root686 = (__x)._right8;
        var _x687 = _root686;
        var _descend688 = true;
        var _from_left689 = true;
        while (true) {
            if ((_x687) == null) {
                _x687 = null;
                break;
            }
            if (_descend688) {
                /* too small? */
                if (false) {
                    if ((!(((_x687)._right8) == null)) && (true)) {
                        if ((_x687) == (_root686)) {
                            _root686 = (_x687)._right8;
                        }
                        _x687 = (_x687)._right8;
                    } else if ((_x687) == (_root686)) {
                        _x687 = null;
                        break;
                    } else {
                        _descend688 = false;
                        _from_left689 = (!(((_x687)._parent9) == null)) && ((_x687) == (((_x687)._parent9)._left7));
                        _x687 = (_x687)._parent9;
                    }
                } else if ((!(((_x687)._left7) == null)) && (true)) {
                    _x687 = (_x687)._left7;
                    /* too large? */
                } else if (false) {
                    if ((_x687) == (_root686)) {
                        _x687 = null;
                        break;
                    } else {
                        _descend688 = false;
                        _from_left689 = (!(((_x687)._parent9) == null)) && ((_x687) == (((_x687)._parent9)._left7));
                        _x687 = (_x687)._parent9;
                    }
                    /* node ok? */
                } else if (true) {
                    break;
                } else if ((_x687) == (_root686)) {
                    _root686 = (_x687)._right8;
                    _x687 = (_x687)._right8;
                } else {
                    if ((!(((_x687)._right8) == null)) && (true)) {
                        if ((_x687) == (_root686)) {
                            _root686 = (_x687)._right8;
                        }
                        _x687 = (_x687)._right8;
                    } else {
                        _descend688 = false;
                        _from_left689 = (!(((_x687)._parent9) == null)) && ((_x687) == (((_x687)._parent9)._left7));
                        _x687 = (_x687)._parent9;
                    }
                }
            } else if (_from_left689) {
                if (false) {
                    _x687 = null;
                    break;
                } else if (true) {
                    break;
                } else if ((!(((_x687)._right8) == null)) && (true)) {
                    _descend688 = true;
                    if ((_x687) == (_root686)) {
                        _root686 = (_x687)._right8;
                    }
                    _x687 = (_x687)._right8;
                } else if ((_x687) == (_root686)) {
                    _x687 = null;
                    break;
                } else {
                    _descend688 = false;
                    _from_left689 = (!(((_x687)._parent9) == null)) && ((_x687) == (((_x687)._parent9)._left7));
                    _x687 = (_x687)._parent9;
                }
            } else {
                if ((_x687) == (_root686)) {
                    _x687 = null;
                    break;
                } else {
                    _descend688 = false;
                    _from_left689 = (!(((_x687)._parent9) == null)) && ((_x687) == (((_x687)._parent9)._left7));
                    _x687 = (_x687)._parent9;
                }
            }
        }
        _new_x685 = _x687;
        var _mp690 = (_x687)._parent9;
        var _mr691 = (_x687)._right8;
        /* replace _x687 with _mr691 in _mp690 */
        if (!((_mp690) == null)) {
            if (((_mp690)._left7) == (_x687)) {
                (_mp690)._left7 = _mr691;
            } else {
                (_mp690)._right8 = _mr691;
            }
        }
        if (!((_mr691) == null)) {
            (_mr691)._parent9 = _mp690;
        }
        /* replace __x with _x687 in _parent682 */
        if (!((_parent682) == null)) {
            if (((_parent682)._left7) == (__x)) {
                (_parent682)._left7 = _x687;
            } else {
                (_parent682)._right8 = _x687;
            }
        }
        if (!((_x687) == null)) {
            (_x687)._parent9 = _parent682;
        }
        /* replace null with _left683 in _x687 */
        (_x687)._left7 = _left683;
        if (!((_left683) == null)) {
            (_left683)._parent9 = _x687;
        }
        /* replace _mr691 with (__x)._right8 in _x687 */
        (_x687)._right8 = (__x)._right8;
        if (!(((__x)._right8) == null)) {
            ((__x)._right8)._parent9 = _x687;
        }
        /* _min_ax12 is min of ax1 */
        var _augval692 = (_x687).ax1;
        var _child693 = (_x687)._left7;
        if (!((_child693) == null)) {
            var _val694 = (_child693)._min_ax12;
            _augval692 = ((_augval692) < (_val694)) ? (_augval692) : (_val694);
        }
        var _child695 = (_x687)._right8;
        if (!((_child695) == null)) {
            var _val696 = (_child695)._min_ax12;
            _augval692 = ((_augval692) < (_val696)) ? (_augval692) : (_val696);
        }
        (_x687)._min_ax12 = _augval692;
        /* _min_ay13 is min of ay1 */
        var _augval697 = (_x687).ay1;
        var _child698 = (_x687)._left7;
        if (!((_child698) == null)) {
            var _val699 = (_child698)._min_ay13;
            _augval697 = ((_augval697) < (_val699)) ? (_augval697) : (_val699);
        }
        var _child700 = (_x687)._right8;
        if (!((_child700) == null)) {
            var _val701 = (_child700)._min_ay13;
            _augval697 = ((_augval697) < (_val701)) ? (_augval697) : (_val701);
        }
        (_x687)._min_ay13 = _augval697;
        /* _max_ay24 is max of ay2 */
        var _augval702 = (_x687).ay2;
        var _child703 = (_x687)._left7;
        if (!((_child703) == null)) {
            var _val704 = (_child703)._max_ay24;
            _augval702 = ((_augval702) < (_val704)) ? (_val704) : (_augval702);
        }
        var _child705 = (_x687)._right8;
        if (!((_child705) == null)) {
            var _val706 = (_child705)._max_ay24;
            _augval702 = ((_augval702) < (_val706)) ? (_val706) : (_augval702);
        }
        (_x687)._max_ay24 = _augval702;
        (_x687)._height10 = 1 + ((((((_x687)._left7) == null) ? (-1) : (((_x687)._left7)._height10)) > ((((_x687)._right8) == null) ? (-1) : (((_x687)._right8)._height10))) ? ((((_x687)._left7) == null) ? (-1) : (((_x687)._left7)._height10)) : ((((_x687)._right8) == null) ? (-1) : (((_x687)._right8)._height10)));
        var _cursor707 = _mp690;
        var _changed708 = true;
        while ((_changed708) && (!((_cursor707) == (_parent682)))) {
            var _old__min_ax12709 = (_cursor707)._min_ax12;
            var _old__min_ay13710 = (_cursor707)._min_ay13;
            var _old__max_ay24711 = (_cursor707)._max_ay24;
            var _old_height712 = (_cursor707)._height10;
            /* _min_ax12 is min of ax1 */
            var _augval713 = (_cursor707).ax1;
            var _child714 = (_cursor707)._left7;
            if (!((_child714) == null)) {
                var _val715 = (_child714)._min_ax12;
                _augval713 = ((_augval713) < (_val715)) ? (_augval713) : (_val715);
            }
            var _child716 = (_cursor707)._right8;
            if (!((_child716) == null)) {
                var _val717 = (_child716)._min_ax12;
                _augval713 = ((_augval713) < (_val717)) ? (_augval713) : (_val717);
            }
            (_cursor707)._min_ax12 = _augval713;
            /* _min_ay13 is min of ay1 */
            var _augval718 = (_cursor707).ay1;
            var _child719 = (_cursor707)._left7;
            if (!((_child719) == null)) {
                var _val720 = (_child719)._min_ay13;
                _augval718 = ((_augval718) < (_val720)) ? (_augval718) : (_val720);
            }
            var _child721 = (_cursor707)._right8;
            if (!((_child721) == null)) {
                var _val722 = (_child721)._min_ay13;
                _augval718 = ((_augval718) < (_val722)) ? (_augval718) : (_val722);
            }
            (_cursor707)._min_ay13 = _augval718;
            /* _max_ay24 is max of ay2 */
            var _augval723 = (_cursor707).ay2;
            var _child724 = (_cursor707)._left7;
            if (!((_child724) == null)) {
                var _val725 = (_child724)._max_ay24;
                _augval723 = ((_augval723) < (_val725)) ? (_val725) : (_augval723);
            }
            var _child726 = (_cursor707)._right8;
            if (!((_child726) == null)) {
                var _val727 = (_child726)._max_ay24;
                _augval723 = ((_augval723) < (_val727)) ? (_val727) : (_augval723);
            }
            (_cursor707)._max_ay24 = _augval723;
            (_cursor707)._height10 = 1 + ((((((_cursor707)._left7) == null) ? (-1) : (((_cursor707)._left7)._height10)) > ((((_cursor707)._right8) == null) ? (-1) : (((_cursor707)._right8)._height10))) ? ((((_cursor707)._left7) == null) ? (-1) : (((_cursor707)._left7)._height10)) : ((((_cursor707)._right8) == null) ? (-1) : (((_cursor707)._right8)._height10)));
            _changed708 = false;
            _changed708 = (_changed708) || (!((_old__min_ax12709) == ((_cursor707)._min_ax12)));
            _changed708 = (_changed708) || (!((_old__min_ay13710) == ((_cursor707)._min_ay13)));
            _changed708 = (_changed708) || (!((_old__max_ay24711) == ((_cursor707)._max_ay24)));
            _changed708 = (_changed708) || (!((_old_height712) == ((_cursor707)._height10)));
            _cursor707 = (_cursor707)._parent9;
        }
    }
    var _cursor728 = _parent682;
    var _changed729 = true;
    while ((_changed729) && (!((_cursor728) == (null)))) {
        var _old__min_ax12730 = (_cursor728)._min_ax12;
        var _old__min_ay13731 = (_cursor728)._min_ay13;
        var _old__max_ay24732 = (_cursor728)._max_ay24;
        var _old_height733 = (_cursor728)._height10;
        /* _min_ax12 is min of ax1 */
        var _augval734 = (_cursor728).ax1;
        var _child735 = (_cursor728)._left7;
        if (!((_child735) == null)) {
            var _val736 = (_child735)._min_ax12;
            _augval734 = ((_augval734) < (_val736)) ? (_augval734) : (_val736);
        }
        var _child737 = (_cursor728)._right8;
        if (!((_child737) == null)) {
            var _val738 = (_child737)._min_ax12;
            _augval734 = ((_augval734) < (_val738)) ? (_augval734) : (_val738);
        }
        (_cursor728)._min_ax12 = _augval734;
        /* _min_ay13 is min of ay1 */
        var _augval739 = (_cursor728).ay1;
        var _child740 = (_cursor728)._left7;
        if (!((_child740) == null)) {
            var _val741 = (_child740)._min_ay13;
            _augval739 = ((_augval739) < (_val741)) ? (_augval739) : (_val741);
        }
        var _child742 = (_cursor728)._right8;
        if (!((_child742) == null)) {
            var _val743 = (_child742)._min_ay13;
            _augval739 = ((_augval739) < (_val743)) ? (_augval739) : (_val743);
        }
        (_cursor728)._min_ay13 = _augval739;
        /* _max_ay24 is max of ay2 */
        var _augval744 = (_cursor728).ay2;
        var _child745 = (_cursor728)._left7;
        if (!((_child745) == null)) {
            var _val746 = (_child745)._max_ay24;
            _augval744 = ((_augval744) < (_val746)) ? (_val746) : (_augval744);
        }
        var _child747 = (_cursor728)._right8;
        if (!((_child747) == null)) {
            var _val748 = (_child747)._max_ay24;
            _augval744 = ((_augval744) < (_val748)) ? (_val748) : (_augval744);
        }
        (_cursor728)._max_ay24 = _augval744;
        (_cursor728)._height10 = 1 + ((((((_cursor728)._left7) == null) ? (-1) : (((_cursor728)._left7)._height10)) > ((((_cursor728)._right8) == null) ? (-1) : (((_cursor728)._right8)._height10))) ? ((((_cursor728)._left7) == null) ? (-1) : (((_cursor728)._left7)._height10)) : ((((_cursor728)._right8) == null) ? (-1) : (((_cursor728)._right8)._height10)));
        _changed729 = false;
        _changed729 = (_changed729) || (!((_old__min_ax12730) == ((_cursor728)._min_ax12)));
        _changed729 = (_changed729) || (!((_old__min_ay13731) == ((_cursor728)._min_ay13)));
        _changed729 = (_changed729) || (!((_old__max_ay24732) == ((_cursor728)._max_ay24)));
        _changed729 = (_changed729) || (!((_old_height733) == ((_cursor728)._height10)));
        _cursor728 = (_cursor728)._parent9;
    }
    if (((this)._root1) == (__x)) {
        (this)._root1 = _new_x685;
    }
    (__x)._left7 = null;
    (__x)._right8 = null;
    (__x)._min_ax12 = (__x).ax1;
    (__x)._min_ay13 = (__x).ay1;
    (__x)._max_ay24 = (__x).ay2;
    (__x)._height10 = 0;
    var _previous749 = null;
    var _current750 = (this)._root1;
    var _is_left751 = false;
    while (!((_current750) == null)) {
        _previous749 = _current750;
        if ((ax2) < ((_current750).ax2)) {
            _current750 = (_current750)._left7;
            _is_left751 = true;
        } else {
            _current750 = (_current750)._right8;
            _is_left751 = false;
        }
    }
    if ((_previous749) == null) {
        (this)._root1 = __x;
    } else {
        (__x)._parent9 = _previous749;
        if (_is_left751) {
            (_previous749)._left7 = __x;
        } else {
            (_previous749)._right8 = __x;
        }
    }
    var _cursor752 = (__x)._parent9;
    var _changed753 = true;
    while ((_changed753) && (!((_cursor752) == (null)))) {
        var _old__min_ax12754 = (_cursor752)._min_ax12;
        var _old__min_ay13755 = (_cursor752)._min_ay13;
        var _old__max_ay24756 = (_cursor752)._max_ay24;
        var _old_height757 = (_cursor752)._height10;
        /* _min_ax12 is min of ax1 */
        var _augval758 = (_cursor752).ax1;
        var _child759 = (_cursor752)._left7;
        if (!((_child759) == null)) {
            var _val760 = (_child759)._min_ax12;
            _augval758 = ((_augval758) < (_val760)) ? (_augval758) : (_val760);
        }
        var _child761 = (_cursor752)._right8;
        if (!((_child761) == null)) {
            var _val762 = (_child761)._min_ax12;
            _augval758 = ((_augval758) < (_val762)) ? (_augval758) : (_val762);
        }
        (_cursor752)._min_ax12 = _augval758;
        /* _min_ay13 is min of ay1 */
        var _augval763 = (_cursor752).ay1;
        var _child764 = (_cursor752)._left7;
        if (!((_child764) == null)) {
            var _val765 = (_child764)._min_ay13;
            _augval763 = ((_augval763) < (_val765)) ? (_augval763) : (_val765);
        }
        var _child766 = (_cursor752)._right8;
        if (!((_child766) == null)) {
            var _val767 = (_child766)._min_ay13;
            _augval763 = ((_augval763) < (_val767)) ? (_augval763) : (_val767);
        }
        (_cursor752)._min_ay13 = _augval763;
        /* _max_ay24 is max of ay2 */
        var _augval768 = (_cursor752).ay2;
        var _child769 = (_cursor752)._left7;
        if (!((_child769) == null)) {
            var _val770 = (_child769)._max_ay24;
            _augval768 = ((_augval768) < (_val770)) ? (_val770) : (_augval768);
        }
        var _child771 = (_cursor752)._right8;
        if (!((_child771) == null)) {
            var _val772 = (_child771)._max_ay24;
            _augval768 = ((_augval768) < (_val772)) ? (_val772) : (_augval768);
        }
        (_cursor752)._max_ay24 = _augval768;
        (_cursor752)._height10 = 1 + ((((((_cursor752)._left7) == null) ? (-1) : (((_cursor752)._left7)._height10)) > ((((_cursor752)._right8) == null) ? (-1) : (((_cursor752)._right8)._height10))) ? ((((_cursor752)._left7) == null) ? (-1) : (((_cursor752)._left7)._height10)) : ((((_cursor752)._right8) == null) ? (-1) : (((_cursor752)._right8)._height10)));
        _changed753 = false;
        _changed753 = (_changed753) || (!((_old__min_ax12754) == ((_cursor752)._min_ax12)));
        _changed753 = (_changed753) || (!((_old__min_ay13755) == ((_cursor752)._min_ay13)));
        _changed753 = (_changed753) || (!((_old__max_ay24756) == ((_cursor752)._max_ay24)));
        _changed753 = (_changed753) || (!((_old_height757) == ((_cursor752)._height10)));
        _cursor752 = (_cursor752)._parent9;
    }
    /* rebalance AVL tree */
    var _cursor773 = __x;
    var _imbalance774;
    while (!(((_cursor773)._parent9) == null)) {
        _cursor773 = (_cursor773)._parent9;
        (_cursor773)._height10 = 1 + ((((((_cursor773)._left7) == null) ? (-1) : (((_cursor773)._left7)._height10)) > ((((_cursor773)._right8) == null) ? (-1) : (((_cursor773)._right8)._height10))) ? ((((_cursor773)._left7) == null) ? (-1) : (((_cursor773)._left7)._height10)) : ((((_cursor773)._right8) == null) ? (-1) : (((_cursor773)._right8)._height10)));
        _imbalance774 = ((((_cursor773)._left7) == null) ? (-1) : (((_cursor773)._left7)._height10)) - ((((_cursor773)._right8) == null) ? (-1) : (((_cursor773)._right8)._height10));
        if ((_imbalance774) > (1)) {
            if ((((((_cursor773)._left7)._left7) == null) ? (-1) : ((((_cursor773)._left7)._left7)._height10)) < (((((_cursor773)._left7)._right8) == null) ? (-1) : ((((_cursor773)._left7)._right8)._height10))) {
                /* rotate ((_cursor773)._left7)._right8 */
                var _a775 = (_cursor773)._left7;
                var _b776 = (_a775)._right8;
                var _c777 = (_b776)._left7;
                /* replace _a775 with _b776 in (_a775)._parent9 */
                if (!(((_a775)._parent9) == null)) {
                    if ((((_a775)._parent9)._left7) == (_a775)) {
                        ((_a775)._parent9)._left7 = _b776;
                    } else {
                        ((_a775)._parent9)._right8 = _b776;
                    }
                }
                if (!((_b776) == null)) {
                    (_b776)._parent9 = (_a775)._parent9;
                }
                /* replace _c777 with _a775 in _b776 */
                (_b776)._left7 = _a775;
                if (!((_a775) == null)) {
                    (_a775)._parent9 = _b776;
                }
                /* replace _b776 with _c777 in _a775 */
                (_a775)._right8 = _c777;
                if (!((_c777) == null)) {
                    (_c777)._parent9 = _a775;
                }
                /* _min_ax12 is min of ax1 */
                var _augval778 = (_a775).ax1;
                var _child779 = (_a775)._left7;
                if (!((_child779) == null)) {
                    var _val780 = (_child779)._min_ax12;
                    _augval778 = ((_augval778) < (_val780)) ? (_augval778) : (_val780);
                }
                var _child781 = (_a775)._right8;
                if (!((_child781) == null)) {
                    var _val782 = (_child781)._min_ax12;
                    _augval778 = ((_augval778) < (_val782)) ? (_augval778) : (_val782);
                }
                (_a775)._min_ax12 = _augval778;
                /* _min_ay13 is min of ay1 */
                var _augval783 = (_a775).ay1;
                var _child784 = (_a775)._left7;
                if (!((_child784) == null)) {
                    var _val785 = (_child784)._min_ay13;
                    _augval783 = ((_augval783) < (_val785)) ? (_augval783) : (_val785);
                }
                var _child786 = (_a775)._right8;
                if (!((_child786) == null)) {
                    var _val787 = (_child786)._min_ay13;
                    _augval783 = ((_augval783) < (_val787)) ? (_augval783) : (_val787);
                }
                (_a775)._min_ay13 = _augval783;
                /* _max_ay24 is max of ay2 */
                var _augval788 = (_a775).ay2;
                var _child789 = (_a775)._left7;
                if (!((_child789) == null)) {
                    var _val790 = (_child789)._max_ay24;
                    _augval788 = ((_augval788) < (_val790)) ? (_val790) : (_augval788);
                }
                var _child791 = (_a775)._right8;
                if (!((_child791) == null)) {
                    var _val792 = (_child791)._max_ay24;
                    _augval788 = ((_augval788) < (_val792)) ? (_val792) : (_augval788);
                }
                (_a775)._max_ay24 = _augval788;
                (_a775)._height10 = 1 + ((((((_a775)._left7) == null) ? (-1) : (((_a775)._left7)._height10)) > ((((_a775)._right8) == null) ? (-1) : (((_a775)._right8)._height10))) ? ((((_a775)._left7) == null) ? (-1) : (((_a775)._left7)._height10)) : ((((_a775)._right8) == null) ? (-1) : (((_a775)._right8)._height10)));
                /* _min_ax12 is min of ax1 */
                var _augval793 = (_b776).ax1;
                var _child794 = (_b776)._left7;
                if (!((_child794) == null)) {
                    var _val795 = (_child794)._min_ax12;
                    _augval793 = ((_augval793) < (_val795)) ? (_augval793) : (_val795);
                }
                var _child796 = (_b776)._right8;
                if (!((_child796) == null)) {
                    var _val797 = (_child796)._min_ax12;
                    _augval793 = ((_augval793) < (_val797)) ? (_augval793) : (_val797);
                }
                (_b776)._min_ax12 = _augval793;
                /* _min_ay13 is min of ay1 */
                var _augval798 = (_b776).ay1;
                var _child799 = (_b776)._left7;
                if (!((_child799) == null)) {
                    var _val800 = (_child799)._min_ay13;
                    _augval798 = ((_augval798) < (_val800)) ? (_augval798) : (_val800);
                }
                var _child801 = (_b776)._right8;
                if (!((_child801) == null)) {
                    var _val802 = (_child801)._min_ay13;
                    _augval798 = ((_augval798) < (_val802)) ? (_augval798) : (_val802);
                }
                (_b776)._min_ay13 = _augval798;
                /* _max_ay24 is max of ay2 */
                var _augval803 = (_b776).ay2;
                var _child804 = (_b776)._left7;
                if (!((_child804) == null)) {
                    var _val805 = (_child804)._max_ay24;
                    _augval803 = ((_augval803) < (_val805)) ? (_val805) : (_augval803);
                }
                var _child806 = (_b776)._right8;
                if (!((_child806) == null)) {
                    var _val807 = (_child806)._max_ay24;
                    _augval803 = ((_augval803) < (_val807)) ? (_val807) : (_augval803);
                }
                (_b776)._max_ay24 = _augval803;
                (_b776)._height10 = 1 + ((((((_b776)._left7) == null) ? (-1) : (((_b776)._left7)._height10)) > ((((_b776)._right8) == null) ? (-1) : (((_b776)._right8)._height10))) ? ((((_b776)._left7) == null) ? (-1) : (((_b776)._left7)._height10)) : ((((_b776)._right8) == null) ? (-1) : (((_b776)._right8)._height10)));
                if (!(((_b776)._parent9) == null)) {
                    /* _min_ax12 is min of ax1 */
                    var _augval808 = ((_b776)._parent9).ax1;
                    var _child809 = ((_b776)._parent9)._left7;
                    if (!((_child809) == null)) {
                        var _val810 = (_child809)._min_ax12;
                        _augval808 = ((_augval808) < (_val810)) ? (_augval808) : (_val810);
                    }
                    var _child811 = ((_b776)._parent9)._right8;
                    if (!((_child811) == null)) {
                        var _val812 = (_child811)._min_ax12;
                        _augval808 = ((_augval808) < (_val812)) ? (_augval808) : (_val812);
                    }
                    ((_b776)._parent9)._min_ax12 = _augval808;
                    /* _min_ay13 is min of ay1 */
                    var _augval813 = ((_b776)._parent9).ay1;
                    var _child814 = ((_b776)._parent9)._left7;
                    if (!((_child814) == null)) {
                        var _val815 = (_child814)._min_ay13;
                        _augval813 = ((_augval813) < (_val815)) ? (_augval813) : (_val815);
                    }
                    var _child816 = ((_b776)._parent9)._right8;
                    if (!((_child816) == null)) {
                        var _val817 = (_child816)._min_ay13;
                        _augval813 = ((_augval813) < (_val817)) ? (_augval813) : (_val817);
                    }
                    ((_b776)._parent9)._min_ay13 = _augval813;
                    /* _max_ay24 is max of ay2 */
                    var _augval818 = ((_b776)._parent9).ay2;
                    var _child819 = ((_b776)._parent9)._left7;
                    if (!((_child819) == null)) {
                        var _val820 = (_child819)._max_ay24;
                        _augval818 = ((_augval818) < (_val820)) ? (_val820) : (_augval818);
                    }
                    var _child821 = ((_b776)._parent9)._right8;
                    if (!((_child821) == null)) {
                        var _val822 = (_child821)._max_ay24;
                        _augval818 = ((_augval818) < (_val822)) ? (_val822) : (_augval818);
                    }
                    ((_b776)._parent9)._max_ay24 = _augval818;
                    ((_b776)._parent9)._height10 = 1 + (((((((_b776)._parent9)._left7) == null) ? (-1) : ((((_b776)._parent9)._left7)._height10)) > (((((_b776)._parent9)._right8) == null) ? (-1) : ((((_b776)._parent9)._right8)._height10))) ? (((((_b776)._parent9)._left7) == null) ? (-1) : ((((_b776)._parent9)._left7)._height10)) : (((((_b776)._parent9)._right8) == null) ? (-1) : ((((_b776)._parent9)._right8)._height10)));
                } else {
                    (this)._root1 = _b776;
                }
            }
            /* rotate (_cursor773)._left7 */
            var _a823 = _cursor773;
            var _b824 = (_a823)._left7;
            var _c825 = (_b824)._right8;
            /* replace _a823 with _b824 in (_a823)._parent9 */
            if (!(((_a823)._parent9) == null)) {
                if ((((_a823)._parent9)._left7) == (_a823)) {
                    ((_a823)._parent9)._left7 = _b824;
                } else {
                    ((_a823)._parent9)._right8 = _b824;
                }
            }
            if (!((_b824) == null)) {
                (_b824)._parent9 = (_a823)._parent9;
            }
            /* replace _c825 with _a823 in _b824 */
            (_b824)._right8 = _a823;
            if (!((_a823) == null)) {
                (_a823)._parent9 = _b824;
            }
            /* replace _b824 with _c825 in _a823 */
            (_a823)._left7 = _c825;
            if (!((_c825) == null)) {
                (_c825)._parent9 = _a823;
            }
            /* _min_ax12 is min of ax1 */
            var _augval826 = (_a823).ax1;
            var _child827 = (_a823)._left7;
            if (!((_child827) == null)) {
                var _val828 = (_child827)._min_ax12;
                _augval826 = ((_augval826) < (_val828)) ? (_augval826) : (_val828);
            }
            var _child829 = (_a823)._right8;
            if (!((_child829) == null)) {
                var _val830 = (_child829)._min_ax12;
                _augval826 = ((_augval826) < (_val830)) ? (_augval826) : (_val830);
            }
            (_a823)._min_ax12 = _augval826;
            /* _min_ay13 is min of ay1 */
            var _augval831 = (_a823).ay1;
            var _child832 = (_a823)._left7;
            if (!((_child832) == null)) {
                var _val833 = (_child832)._min_ay13;
                _augval831 = ((_augval831) < (_val833)) ? (_augval831) : (_val833);
            }
            var _child834 = (_a823)._right8;
            if (!((_child834) == null)) {
                var _val835 = (_child834)._min_ay13;
                _augval831 = ((_augval831) < (_val835)) ? (_augval831) : (_val835);
            }
            (_a823)._min_ay13 = _augval831;
            /* _max_ay24 is max of ay2 */
            var _augval836 = (_a823).ay2;
            var _child837 = (_a823)._left7;
            if (!((_child837) == null)) {
                var _val838 = (_child837)._max_ay24;
                _augval836 = ((_augval836) < (_val838)) ? (_val838) : (_augval836);
            }
            var _child839 = (_a823)._right8;
            if (!((_child839) == null)) {
                var _val840 = (_child839)._max_ay24;
                _augval836 = ((_augval836) < (_val840)) ? (_val840) : (_augval836);
            }
            (_a823)._max_ay24 = _augval836;
            (_a823)._height10 = 1 + ((((((_a823)._left7) == null) ? (-1) : (((_a823)._left7)._height10)) > ((((_a823)._right8) == null) ? (-1) : (((_a823)._right8)._height10))) ? ((((_a823)._left7) == null) ? (-1) : (((_a823)._left7)._height10)) : ((((_a823)._right8) == null) ? (-1) : (((_a823)._right8)._height10)));
            /* _min_ax12 is min of ax1 */
            var _augval841 = (_b824).ax1;
            var _child842 = (_b824)._left7;
            if (!((_child842) == null)) {
                var _val843 = (_child842)._min_ax12;
                _augval841 = ((_augval841) < (_val843)) ? (_augval841) : (_val843);
            }
            var _child844 = (_b824)._right8;
            if (!((_child844) == null)) {
                var _val845 = (_child844)._min_ax12;
                _augval841 = ((_augval841) < (_val845)) ? (_augval841) : (_val845);
            }
            (_b824)._min_ax12 = _augval841;
            /* _min_ay13 is min of ay1 */
            var _augval846 = (_b824).ay1;
            var _child847 = (_b824)._left7;
            if (!((_child847) == null)) {
                var _val848 = (_child847)._min_ay13;
                _augval846 = ((_augval846) < (_val848)) ? (_augval846) : (_val848);
            }
            var _child849 = (_b824)._right8;
            if (!((_child849) == null)) {
                var _val850 = (_child849)._min_ay13;
                _augval846 = ((_augval846) < (_val850)) ? (_augval846) : (_val850);
            }
            (_b824)._min_ay13 = _augval846;
            /* _max_ay24 is max of ay2 */
            var _augval851 = (_b824).ay2;
            var _child852 = (_b824)._left7;
            if (!((_child852) == null)) {
                var _val853 = (_child852)._max_ay24;
                _augval851 = ((_augval851) < (_val853)) ? (_val853) : (_augval851);
            }
            var _child854 = (_b824)._right8;
            if (!((_child854) == null)) {
                var _val855 = (_child854)._max_ay24;
                _augval851 = ((_augval851) < (_val855)) ? (_val855) : (_augval851);
            }
            (_b824)._max_ay24 = _augval851;
            (_b824)._height10 = 1 + ((((((_b824)._left7) == null) ? (-1) : (((_b824)._left7)._height10)) > ((((_b824)._right8) == null) ? (-1) : (((_b824)._right8)._height10))) ? ((((_b824)._left7) == null) ? (-1) : (((_b824)._left7)._height10)) : ((((_b824)._right8) == null) ? (-1) : (((_b824)._right8)._height10)));
            if (!(((_b824)._parent9) == null)) {
                /* _min_ax12 is min of ax1 */
                var _augval856 = ((_b824)._parent9).ax1;
                var _child857 = ((_b824)._parent9)._left7;
                if (!((_child857) == null)) {
                    var _val858 = (_child857)._min_ax12;
                    _augval856 = ((_augval856) < (_val858)) ? (_augval856) : (_val858);
                }
                var _child859 = ((_b824)._parent9)._right8;
                if (!((_child859) == null)) {
                    var _val860 = (_child859)._min_ax12;
                    _augval856 = ((_augval856) < (_val860)) ? (_augval856) : (_val860);
                }
                ((_b824)._parent9)._min_ax12 = _augval856;
                /* _min_ay13 is min of ay1 */
                var _augval861 = ((_b824)._parent9).ay1;
                var _child862 = ((_b824)._parent9)._left7;
                if (!((_child862) == null)) {
                    var _val863 = (_child862)._min_ay13;
                    _augval861 = ((_augval861) < (_val863)) ? (_augval861) : (_val863);
                }
                var _child864 = ((_b824)._parent9)._right8;
                if (!((_child864) == null)) {
                    var _val865 = (_child864)._min_ay13;
                    _augval861 = ((_augval861) < (_val865)) ? (_augval861) : (_val865);
                }
                ((_b824)._parent9)._min_ay13 = _augval861;
                /* _max_ay24 is max of ay2 */
                var _augval866 = ((_b824)._parent9).ay2;
                var _child867 = ((_b824)._parent9)._left7;
                if (!((_child867) == null)) {
                    var _val868 = (_child867)._max_ay24;
                    _augval866 = ((_augval866) < (_val868)) ? (_val868) : (_augval866);
                }
                var _child869 = ((_b824)._parent9)._right8;
                if (!((_child869) == null)) {
                    var _val870 = (_child869)._max_ay24;
                    _augval866 = ((_augval866) < (_val870)) ? (_val870) : (_augval866);
                }
                ((_b824)._parent9)._max_ay24 = _augval866;
                ((_b824)._parent9)._height10 = 1 + (((((((_b824)._parent9)._left7) == null) ? (-1) : ((((_b824)._parent9)._left7)._height10)) > (((((_b824)._parent9)._right8) == null) ? (-1) : ((((_b824)._parent9)._right8)._height10))) ? (((((_b824)._parent9)._left7) == null) ? (-1) : ((((_b824)._parent9)._left7)._height10)) : (((((_b824)._parent9)._right8) == null) ? (-1) : ((((_b824)._parent9)._right8)._height10)));
            } else {
                (this)._root1 = _b824;
            }
            _cursor773 = (_cursor773)._parent9;
        } else if ((_imbalance774) < (-1)) {
            if ((((((_cursor773)._right8)._left7) == null) ? (-1) : ((((_cursor773)._right8)._left7)._height10)) > (((((_cursor773)._right8)._right8) == null) ? (-1) : ((((_cursor773)._right8)._right8)._height10))) {
                /* rotate ((_cursor773)._right8)._left7 */
                var _a871 = (_cursor773)._right8;
                var _b872 = (_a871)._left7;
                var _c873 = (_b872)._right8;
                /* replace _a871 with _b872 in (_a871)._parent9 */
                if (!(((_a871)._parent9) == null)) {
                    if ((((_a871)._parent9)._left7) == (_a871)) {
                        ((_a871)._parent9)._left7 = _b872;
                    } else {
                        ((_a871)._parent9)._right8 = _b872;
                    }
                }
                if (!((_b872) == null)) {
                    (_b872)._parent9 = (_a871)._parent9;
                }
                /* replace _c873 with _a871 in _b872 */
                (_b872)._right8 = _a871;
                if (!((_a871) == null)) {
                    (_a871)._parent9 = _b872;
                }
                /* replace _b872 with _c873 in _a871 */
                (_a871)._left7 = _c873;
                if (!((_c873) == null)) {
                    (_c873)._parent9 = _a871;
                }
                /* _min_ax12 is min of ax1 */
                var _augval874 = (_a871).ax1;
                var _child875 = (_a871)._left7;
                if (!((_child875) == null)) {
                    var _val876 = (_child875)._min_ax12;
                    _augval874 = ((_augval874) < (_val876)) ? (_augval874) : (_val876);
                }
                var _child877 = (_a871)._right8;
                if (!((_child877) == null)) {
                    var _val878 = (_child877)._min_ax12;
                    _augval874 = ((_augval874) < (_val878)) ? (_augval874) : (_val878);
                }
                (_a871)._min_ax12 = _augval874;
                /* _min_ay13 is min of ay1 */
                var _augval879 = (_a871).ay1;
                var _child880 = (_a871)._left7;
                if (!((_child880) == null)) {
                    var _val881 = (_child880)._min_ay13;
                    _augval879 = ((_augval879) < (_val881)) ? (_augval879) : (_val881);
                }
                var _child882 = (_a871)._right8;
                if (!((_child882) == null)) {
                    var _val883 = (_child882)._min_ay13;
                    _augval879 = ((_augval879) < (_val883)) ? (_augval879) : (_val883);
                }
                (_a871)._min_ay13 = _augval879;
                /* _max_ay24 is max of ay2 */
                var _augval884 = (_a871).ay2;
                var _child885 = (_a871)._left7;
                if (!((_child885) == null)) {
                    var _val886 = (_child885)._max_ay24;
                    _augval884 = ((_augval884) < (_val886)) ? (_val886) : (_augval884);
                }
                var _child887 = (_a871)._right8;
                if (!((_child887) == null)) {
                    var _val888 = (_child887)._max_ay24;
                    _augval884 = ((_augval884) < (_val888)) ? (_val888) : (_augval884);
                }
                (_a871)._max_ay24 = _augval884;
                (_a871)._height10 = 1 + ((((((_a871)._left7) == null) ? (-1) : (((_a871)._left7)._height10)) > ((((_a871)._right8) == null) ? (-1) : (((_a871)._right8)._height10))) ? ((((_a871)._left7) == null) ? (-1) : (((_a871)._left7)._height10)) : ((((_a871)._right8) == null) ? (-1) : (((_a871)._right8)._height10)));
                /* _min_ax12 is min of ax1 */
                var _augval889 = (_b872).ax1;
                var _child890 = (_b872)._left7;
                if (!((_child890) == null)) {
                    var _val891 = (_child890)._min_ax12;
                    _augval889 = ((_augval889) < (_val891)) ? (_augval889) : (_val891);
                }
                var _child892 = (_b872)._right8;
                if (!((_child892) == null)) {
                    var _val893 = (_child892)._min_ax12;
                    _augval889 = ((_augval889) < (_val893)) ? (_augval889) : (_val893);
                }
                (_b872)._min_ax12 = _augval889;
                /* _min_ay13 is min of ay1 */
                var _augval894 = (_b872).ay1;
                var _child895 = (_b872)._left7;
                if (!((_child895) == null)) {
                    var _val896 = (_child895)._min_ay13;
                    _augval894 = ((_augval894) < (_val896)) ? (_augval894) : (_val896);
                }
                var _child897 = (_b872)._right8;
                if (!((_child897) == null)) {
                    var _val898 = (_child897)._min_ay13;
                    _augval894 = ((_augval894) < (_val898)) ? (_augval894) : (_val898);
                }
                (_b872)._min_ay13 = _augval894;
                /* _max_ay24 is max of ay2 */
                var _augval899 = (_b872).ay2;
                var _child900 = (_b872)._left7;
                if (!((_child900) == null)) {
                    var _val901 = (_child900)._max_ay24;
                    _augval899 = ((_augval899) < (_val901)) ? (_val901) : (_augval899);
                }
                var _child902 = (_b872)._right8;
                if (!((_child902) == null)) {
                    var _val903 = (_child902)._max_ay24;
                    _augval899 = ((_augval899) < (_val903)) ? (_val903) : (_augval899);
                }
                (_b872)._max_ay24 = _augval899;
                (_b872)._height10 = 1 + ((((((_b872)._left7) == null) ? (-1) : (((_b872)._left7)._height10)) > ((((_b872)._right8) == null) ? (-1) : (((_b872)._right8)._height10))) ? ((((_b872)._left7) == null) ? (-1) : (((_b872)._left7)._height10)) : ((((_b872)._right8) == null) ? (-1) : (((_b872)._right8)._height10)));
                if (!(((_b872)._parent9) == null)) {
                    /* _min_ax12 is min of ax1 */
                    var _augval904 = ((_b872)._parent9).ax1;
                    var _child905 = ((_b872)._parent9)._left7;
                    if (!((_child905) == null)) {
                        var _val906 = (_child905)._min_ax12;
                        _augval904 = ((_augval904) < (_val906)) ? (_augval904) : (_val906);
                    }
                    var _child907 = ((_b872)._parent9)._right8;
                    if (!((_child907) == null)) {
                        var _val908 = (_child907)._min_ax12;
                        _augval904 = ((_augval904) < (_val908)) ? (_augval904) : (_val908);
                    }
                    ((_b872)._parent9)._min_ax12 = _augval904;
                    /* _min_ay13 is min of ay1 */
                    var _augval909 = ((_b872)._parent9).ay1;
                    var _child910 = ((_b872)._parent9)._left7;
                    if (!((_child910) == null)) {
                        var _val911 = (_child910)._min_ay13;
                        _augval909 = ((_augval909) < (_val911)) ? (_augval909) : (_val911);
                    }
                    var _child912 = ((_b872)._parent9)._right8;
                    if (!((_child912) == null)) {
                        var _val913 = (_child912)._min_ay13;
                        _augval909 = ((_augval909) < (_val913)) ? (_augval909) : (_val913);
                    }
                    ((_b872)._parent9)._min_ay13 = _augval909;
                    /* _max_ay24 is max of ay2 */
                    var _augval914 = ((_b872)._parent9).ay2;
                    var _child915 = ((_b872)._parent9)._left7;
                    if (!((_child915) == null)) {
                        var _val916 = (_child915)._max_ay24;
                        _augval914 = ((_augval914) < (_val916)) ? (_val916) : (_augval914);
                    }
                    var _child917 = ((_b872)._parent9)._right8;
                    if (!((_child917) == null)) {
                        var _val918 = (_child917)._max_ay24;
                        _augval914 = ((_augval914) < (_val918)) ? (_val918) : (_augval914);
                    }
                    ((_b872)._parent9)._max_ay24 = _augval914;
                    ((_b872)._parent9)._height10 = 1 + (((((((_b872)._parent9)._left7) == null) ? (-1) : ((((_b872)._parent9)._left7)._height10)) > (((((_b872)._parent9)._right8) == null) ? (-1) : ((((_b872)._parent9)._right8)._height10))) ? (((((_b872)._parent9)._left7) == null) ? (-1) : ((((_b872)._parent9)._left7)._height10)) : (((((_b872)._parent9)._right8) == null) ? (-1) : ((((_b872)._parent9)._right8)._height10)));
                } else {
                    (this)._root1 = _b872;
                }
            }
            /* rotate (_cursor773)._right8 */
            var _a919 = _cursor773;
            var _b920 = (_a919)._right8;
            var _c921 = (_b920)._left7;
            /* replace _a919 with _b920 in (_a919)._parent9 */
            if (!(((_a919)._parent9) == null)) {
                if ((((_a919)._parent9)._left7) == (_a919)) {
                    ((_a919)._parent9)._left7 = _b920;
                } else {
                    ((_a919)._parent9)._right8 = _b920;
                }
            }
            if (!((_b920) == null)) {
                (_b920)._parent9 = (_a919)._parent9;
            }
            /* replace _c921 with _a919 in _b920 */
            (_b920)._left7 = _a919;
            if (!((_a919) == null)) {
                (_a919)._parent9 = _b920;
            }
            /* replace _b920 with _c921 in _a919 */
            (_a919)._right8 = _c921;
            if (!((_c921) == null)) {
                (_c921)._parent9 = _a919;
            }
            /* _min_ax12 is min of ax1 */
            var _augval922 = (_a919).ax1;
            var _child923 = (_a919)._left7;
            if (!((_child923) == null)) {
                var _val924 = (_child923)._min_ax12;
                _augval922 = ((_augval922) < (_val924)) ? (_augval922) : (_val924);
            }
            var _child925 = (_a919)._right8;
            if (!((_child925) == null)) {
                var _val926 = (_child925)._min_ax12;
                _augval922 = ((_augval922) < (_val926)) ? (_augval922) : (_val926);
            }
            (_a919)._min_ax12 = _augval922;
            /* _min_ay13 is min of ay1 */
            var _augval927 = (_a919).ay1;
            var _child928 = (_a919)._left7;
            if (!((_child928) == null)) {
                var _val929 = (_child928)._min_ay13;
                _augval927 = ((_augval927) < (_val929)) ? (_augval927) : (_val929);
            }
            var _child930 = (_a919)._right8;
            if (!((_child930) == null)) {
                var _val931 = (_child930)._min_ay13;
                _augval927 = ((_augval927) < (_val931)) ? (_augval927) : (_val931);
            }
            (_a919)._min_ay13 = _augval927;
            /* _max_ay24 is max of ay2 */
            var _augval932 = (_a919).ay2;
            var _child933 = (_a919)._left7;
            if (!((_child933) == null)) {
                var _val934 = (_child933)._max_ay24;
                _augval932 = ((_augval932) < (_val934)) ? (_val934) : (_augval932);
            }
            var _child935 = (_a919)._right8;
            if (!((_child935) == null)) {
                var _val936 = (_child935)._max_ay24;
                _augval932 = ((_augval932) < (_val936)) ? (_val936) : (_augval932);
            }
            (_a919)._max_ay24 = _augval932;
            (_a919)._height10 = 1 + ((((((_a919)._left7) == null) ? (-1) : (((_a919)._left7)._height10)) > ((((_a919)._right8) == null) ? (-1) : (((_a919)._right8)._height10))) ? ((((_a919)._left7) == null) ? (-1) : (((_a919)._left7)._height10)) : ((((_a919)._right8) == null) ? (-1) : (((_a919)._right8)._height10)));
            /* _min_ax12 is min of ax1 */
            var _augval937 = (_b920).ax1;
            var _child938 = (_b920)._left7;
            if (!((_child938) == null)) {
                var _val939 = (_child938)._min_ax12;
                _augval937 = ((_augval937) < (_val939)) ? (_augval937) : (_val939);
            }
            var _child940 = (_b920)._right8;
            if (!((_child940) == null)) {
                var _val941 = (_child940)._min_ax12;
                _augval937 = ((_augval937) < (_val941)) ? (_augval937) : (_val941);
            }
            (_b920)._min_ax12 = _augval937;
            /* _min_ay13 is min of ay1 */
            var _augval942 = (_b920).ay1;
            var _child943 = (_b920)._left7;
            if (!((_child943) == null)) {
                var _val944 = (_child943)._min_ay13;
                _augval942 = ((_augval942) < (_val944)) ? (_augval942) : (_val944);
            }
            var _child945 = (_b920)._right8;
            if (!((_child945) == null)) {
                var _val946 = (_child945)._min_ay13;
                _augval942 = ((_augval942) < (_val946)) ? (_augval942) : (_val946);
            }
            (_b920)._min_ay13 = _augval942;
            /* _max_ay24 is max of ay2 */
            var _augval947 = (_b920).ay2;
            var _child948 = (_b920)._left7;
            if (!((_child948) == null)) {
                var _val949 = (_child948)._max_ay24;
                _augval947 = ((_augval947) < (_val949)) ? (_val949) : (_augval947);
            }
            var _child950 = (_b920)._right8;
            if (!((_child950) == null)) {
                var _val951 = (_child950)._max_ay24;
                _augval947 = ((_augval947) < (_val951)) ? (_val951) : (_augval947);
            }
            (_b920)._max_ay24 = _augval947;
            (_b920)._height10 = 1 + ((((((_b920)._left7) == null) ? (-1) : (((_b920)._left7)._height10)) > ((((_b920)._right8) == null) ? (-1) : (((_b920)._right8)._height10))) ? ((((_b920)._left7) == null) ? (-1) : (((_b920)._left7)._height10)) : ((((_b920)._right8) == null) ? (-1) : (((_b920)._right8)._height10)));
            if (!(((_b920)._parent9) == null)) {
                /* _min_ax12 is min of ax1 */
                var _augval952 = ((_b920)._parent9).ax1;
                var _child953 = ((_b920)._parent9)._left7;
                if (!((_child953) == null)) {
                    var _val954 = (_child953)._min_ax12;
                    _augval952 = ((_augval952) < (_val954)) ? (_augval952) : (_val954);
                }
                var _child955 = ((_b920)._parent9)._right8;
                if (!((_child955) == null)) {
                    var _val956 = (_child955)._min_ax12;
                    _augval952 = ((_augval952) < (_val956)) ? (_augval952) : (_val956);
                }
                ((_b920)._parent9)._min_ax12 = _augval952;
                /* _min_ay13 is min of ay1 */
                var _augval957 = ((_b920)._parent9).ay1;
                var _child958 = ((_b920)._parent9)._left7;
                if (!((_child958) == null)) {
                    var _val959 = (_child958)._min_ay13;
                    _augval957 = ((_augval957) < (_val959)) ? (_augval957) : (_val959);
                }
                var _child960 = ((_b920)._parent9)._right8;
                if (!((_child960) == null)) {
                    var _val961 = (_child960)._min_ay13;
                    _augval957 = ((_augval957) < (_val961)) ? (_augval957) : (_val961);
                }
                ((_b920)._parent9)._min_ay13 = _augval957;
                /* _max_ay24 is max of ay2 */
                var _augval962 = ((_b920)._parent9).ay2;
                var _child963 = ((_b920)._parent9)._left7;
                if (!((_child963) == null)) {
                    var _val964 = (_child963)._max_ay24;
                    _augval962 = ((_augval962) < (_val964)) ? (_val964) : (_augval962);
                }
                var _child965 = ((_b920)._parent9)._right8;
                if (!((_child965) == null)) {
                    var _val966 = (_child965)._max_ay24;
                    _augval962 = ((_augval962) < (_val966)) ? (_val966) : (_augval962);
                }
                ((_b920)._parent9)._max_ay24 = _augval962;
                ((_b920)._parent9)._height10 = 1 + (((((((_b920)._parent9)._left7) == null) ? (-1) : ((((_b920)._parent9)._left7)._height10)) > (((((_b920)._parent9)._right8) == null) ? (-1) : ((((_b920)._parent9)._right8)._height10))) ? (((((_b920)._parent9)._left7) == null) ? (-1) : ((((_b920)._parent9)._left7)._height10)) : (((((_b920)._parent9)._right8) == null) ? (-1) : ((((_b920)._parent9)._right8)._height10)));
            } else {
                (this)._root1 = _b920;
            }
            _cursor773 = (_cursor773)._parent9;
        }
    }
    (__x).ax1 = ax1;
    (__x).ay1 = ay1;
    (__x).ax2 = ax2;
    (__x).ay2 = ay2;
}
RectangleHolder.prototype.findMatchingRectangles = function (bx1, by1, bx2, by2, __callback) {
    var _root967 = (this)._root1;
    var _x968 = _root967;
    var _descend969 = true;
    var _from_left970 = true;
    while (true) {
        if ((_x968) == null) {
            _x968 = null;
            break;
        }
        if (_descend969) {
            /* too small? */
            if ((false) || (((_x968).ax2) <= (bx1))) {
                if ((!(((_x968)._right8) == null)) && ((((true) && ((((_x968)._right8)._min_ax12) < (bx2))) && ((((_x968)._right8)._min_ay13) < (by2))) && ((((_x968)._right8)._max_ay24) > (by1)))) {
                    if ((_x968) == (_root967)) {
                        _root967 = (_x968)._right8;
                    }
                    _x968 = (_x968)._right8;
                } else if ((_x968) == (_root967)) {
                    _x968 = null;
                    break;
                } else {
                    _descend969 = false;
                    _from_left970 = (!(((_x968)._parent9) == null)) && ((_x968) == (((_x968)._parent9)._left7));
                    _x968 = (_x968)._parent9;
                }
            } else if ((!(((_x968)._left7) == null)) && ((((true) && ((((_x968)._left7)._min_ax12) < (bx2))) && ((((_x968)._left7)._min_ay13) < (by2))) && ((((_x968)._left7)._max_ay24) > (by1)))) {
                _x968 = (_x968)._left7;
                /* too large? */
            } else if (false) {
                if ((_x968) == (_root967)) {
                    _x968 = null;
                    break;
                } else {
                    _descend969 = false;
                    _from_left970 = (!(((_x968)._parent9) == null)) && ((_x968) == (((_x968)._parent9)._left7));
                    _x968 = (_x968)._parent9;
                }
                /* node ok? */
            } else if ((((true) && (((_x968).ax1) < (bx2))) && (((_x968).ay1) < (by2))) && (((_x968).ay2) > (by1))) {
                break;
            } else if ((_x968) == (_root967)) {
                _root967 = (_x968)._right8;
                _x968 = (_x968)._right8;
            } else {
                if ((!(((_x968)._right8) == null)) && ((((true) && ((((_x968)._right8)._min_ax12) < (bx2))) && ((((_x968)._right8)._min_ay13) < (by2))) && ((((_x968)._right8)._max_ay24) > (by1)))) {
                    if ((_x968) == (_root967)) {
                        _root967 = (_x968)._right8;
                    }
                    _x968 = (_x968)._right8;
                } else {
                    _descend969 = false;
                    _from_left970 = (!(((_x968)._parent9) == null)) && ((_x968) == (((_x968)._parent9)._left7));
                    _x968 = (_x968)._parent9;
                }
            }
        } else if (_from_left970) {
            if (false) {
                _x968 = null;
                break;
            } else if ((((true) && (((_x968).ax1) < (bx2))) && (((_x968).ay1) < (by2))) && (((_x968).ay2) > (by1))) {
                break;
            } else if ((!(((_x968)._right8) == null)) && ((((true) && ((((_x968)._right8)._min_ax12) < (bx2))) && ((((_x968)._right8)._min_ay13) < (by2))) && ((((_x968)._right8)._max_ay24) > (by1)))) {
                _descend969 = true;
                if ((_x968) == (_root967)) {
                    _root967 = (_x968)._right8;
                }
                _x968 = (_x968)._right8;
            } else if ((_x968) == (_root967)) {
                _x968 = null;
                break;
            } else {
                _descend969 = false;
                _from_left970 = (!(((_x968)._parent9) == null)) && ((_x968) == (((_x968)._parent9)._left7));
                _x968 = (_x968)._parent9;
            }
        } else {
            if ((_x968) == (_root967)) {
                _x968 = null;
                break;
            } else {
                _descend969 = false;
                _from_left970 = (!(((_x968)._parent9) == null)) && ((_x968) == (((_x968)._parent9)._left7));
                _x968 = (_x968)._parent9;
            }
        }
    }
    var _prev_cursor5 = null;
    var _cursor6 = _x968;
    for (; ;) {
        if (!(!((_cursor6) == null))) break;
        var _name971 = _cursor6;
        /* ADVANCE */
        _prev_cursor5 = _cursor6;
        do {
            var _right_min972 = null;
            if ((!(((_cursor6)._right8) == null)) && ((((true) && ((((_cursor6)._right8)._min_ax12) < (bx2))) && ((((_cursor6)._right8)._min_ay13) < (by2))) && ((((_cursor6)._right8)._max_ay24) > (by1)))) {
                var _root973 = (_cursor6)._right8;
                var _x974 = _root973;
                var _descend975 = true;
                var _from_left976 = true;
                while (true) {
                    if ((_x974) == null) {
                        _x974 = null;
                        break;
                    }
                    if (_descend975) {
                        /* too small? */
                        if ((false) || (((_x974).ax2) <= (bx1))) {
                            if ((!(((_x974)._right8) == null)) && ((((true) && ((((_x974)._right8)._min_ax12) < (bx2))) && ((((_x974)._right8)._min_ay13) < (by2))) && ((((_x974)._right8)._max_ay24) > (by1)))) {
                                if ((_x974) == (_root973)) {
                                    _root973 = (_x974)._right8;
                                }
                                _x974 = (_x974)._right8;
                            } else if ((_x974) == (_root973)) {
                                _x974 = null;
                                break;
                            } else {
                                _descend975 = false;
                                _from_left976 = (!(((_x974)._parent9) == null)) && ((_x974) == (((_x974)._parent9)._left7));
                                _x974 = (_x974)._parent9;
                            }
                        } else if ((!(((_x974)._left7) == null)) && ((((true) && ((((_x974)._left7)._min_ax12) < (bx2))) && ((((_x974)._left7)._min_ay13) < (by2))) && ((((_x974)._left7)._max_ay24) > (by1)))) {
                            _x974 = (_x974)._left7;
                            /* too large? */
                        } else if (false) {
                            if ((_x974) == (_root973)) {
                                _x974 = null;
                                break;
                            } else {
                                _descend975 = false;
                                _from_left976 = (!(((_x974)._parent9) == null)) && ((_x974) == (((_x974)._parent9)._left7));
                                _x974 = (_x974)._parent9;
                            }
                            /* node ok? */
                        } else if ((((true) && (((_x974).ax1) < (bx2))) && (((_x974).ay1) < (by2))) && (((_x974).ay2) > (by1))) {
                            break;
                        } else if ((_x974) == (_root973)) {
                            _root973 = (_x974)._right8;
                            _x974 = (_x974)._right8;
                        } else {
                            if ((!(((_x974)._right8) == null)) && ((((true) && ((((_x974)._right8)._min_ax12) < (bx2))) && ((((_x974)._right8)._min_ay13) < (by2))) && ((((_x974)._right8)._max_ay24) > (by1)))) {
                                if ((_x974) == (_root973)) {
                                    _root973 = (_x974)._right8;
                                }
                                _x974 = (_x974)._right8;
                            } else {
                                _descend975 = false;
                                _from_left976 = (!(((_x974)._parent9) == null)) && ((_x974) == (((_x974)._parent9)._left7));
                                _x974 = (_x974)._parent9;
                            }
                        }
                    } else if (_from_left976) {
                        if (false) {
                            _x974 = null;
                            break;
                        } else if ((((true) && (((_x974).ax1) < (bx2))) && (((_x974).ay1) < (by2))) && (((_x974).ay2) > (by1))) {
                            break;
                        } else if ((!(((_x974)._right8) == null)) && ((((true) && ((((_x974)._right8)._min_ax12) < (bx2))) && ((((_x974)._right8)._min_ay13) < (by2))) && ((((_x974)._right8)._max_ay24) > (by1)))) {
                            _descend975 = true;
                            if ((_x974) == (_root973)) {
                                _root973 = (_x974)._right8;
                            }
                            _x974 = (_x974)._right8;
                        } else if ((_x974) == (_root973)) {
                            _x974 = null;
                            break;
                        } else {
                            _descend975 = false;
                            _from_left976 = (!(((_x974)._parent9) == null)) && ((_x974) == (((_x974)._parent9)._left7));
                            _x974 = (_x974)._parent9;
                        }
                    } else {
                        if ((_x974) == (_root973)) {
                            _x974 = null;
                            break;
                        } else {
                            _descend975 = false;
                            _from_left976 = (!(((_x974)._parent9) == null)) && ((_x974) == (((_x974)._parent9)._left7));
                            _x974 = (_x974)._parent9;
                        }
                    }
                }
                _right_min972 = _x974;
            }
            if (!((_right_min972) == null)) {
                _cursor6 = _right_min972;
                break;
            } else {
                while ((!(((_cursor6)._parent9) == null)) && ((_cursor6) == (((_cursor6)._parent9)._right8))) {
                    _cursor6 = (_cursor6)._parent9;
                }
                _cursor6 = (_cursor6)._parent9;
                if ((!((_cursor6) == null)) && (false)) {
                    _cursor6 = null;
                }
            }
        } while ((!((_cursor6) == null)) && (!((((true) && (((_cursor6).ax1) < (bx2))) && (((_cursor6).ay1) < (by2))) && (((_cursor6).ay2) > (by1)))));
        if (__callback(_name971)) {
            var _to_remove977 = _prev_cursor5;
            var _parent978 = (_to_remove977)._parent9;
            var _left979 = (_to_remove977)._left7;
            var _right980 = (_to_remove977)._right8;
            var _new_x981;
            if (((_left979) == null) && ((_right980) == null)) {
                _new_x981 = null;
                /* replace _to_remove977 with _new_x981 in _parent978 */
                if (!((_parent978) == null)) {
                    if (((_parent978)._left7) == (_to_remove977)) {
                        (_parent978)._left7 = _new_x981;
                    } else {
                        (_parent978)._right8 = _new_x981;
                    }
                }
                if (!((_new_x981) == null)) {
                    (_new_x981)._parent9 = _parent978;
                }
            } else if ((!((_left979) == null)) && ((_right980) == null)) {
                _new_x981 = _left979;
                /* replace _to_remove977 with _new_x981 in _parent978 */
                if (!((_parent978) == null)) {
                    if (((_parent978)._left7) == (_to_remove977)) {
                        (_parent978)._left7 = _new_x981;
                    } else {
                        (_parent978)._right8 = _new_x981;
                    }
                }
                if (!((_new_x981) == null)) {
                    (_new_x981)._parent9 = _parent978;
                }
            } else if (((_left979) == null) && (!((_right980) == null))) {
                _new_x981 = _right980;
                /* replace _to_remove977 with _new_x981 in _parent978 */
                if (!((_parent978) == null)) {
                    if (((_parent978)._left7) == (_to_remove977)) {
                        (_parent978)._left7 = _new_x981;
                    } else {
                        (_parent978)._right8 = _new_x981;
                    }
                }
                if (!((_new_x981) == null)) {
                    (_new_x981)._parent9 = _parent978;
                }
            } else {
                var _root982 = (_to_remove977)._right8;
                var _x983 = _root982;
                var _descend984 = true;
                var _from_left985 = true;
                while (true) {
                    if ((_x983) == null) {
                        _x983 = null;
                        break;
                    }
                    if (_descend984) {
                        /* too small? */
                        if (false) {
                            if ((!(((_x983)._right8) == null)) && (true)) {
                                if ((_x983) == (_root982)) {
                                    _root982 = (_x983)._right8;
                                }
                                _x983 = (_x983)._right8;
                            } else if ((_x983) == (_root982)) {
                                _x983 = null;
                                break;
                            } else {
                                _descend984 = false;
                                _from_left985 = (!(((_x983)._parent9) == null)) && ((_x983) == (((_x983)._parent9)._left7));
                                _x983 = (_x983)._parent9;
                            }
                        } else if ((!(((_x983)._left7) == null)) && (true)) {
                            _x983 = (_x983)._left7;
                            /* too large? */
                        } else if (false) {
                            if ((_x983) == (_root982)) {
                                _x983 = null;
                                break;
                            } else {
                                _descend984 = false;
                                _from_left985 = (!(((_x983)._parent9) == null)) && ((_x983) == (((_x983)._parent9)._left7));
                                _x983 = (_x983)._parent9;
                            }
                            /* node ok? */
                        } else if (true) {
                            break;
                        } else if ((_x983) == (_root982)) {
                            _root982 = (_x983)._right8;
                            _x983 = (_x983)._right8;
                        } else {
                            if ((!(((_x983)._right8) == null)) && (true)) {
                                if ((_x983) == (_root982)) {
                                    _root982 = (_x983)._right8;
                                }
                                _x983 = (_x983)._right8;
                            } else {
                                _descend984 = false;
                                _from_left985 = (!(((_x983)._parent9) == null)) && ((_x983) == (((_x983)._parent9)._left7));
                                _x983 = (_x983)._parent9;
                            }
                        }
                    } else if (_from_left985) {
                        if (false) {
                            _x983 = null;
                            break;
                        } else if (true) {
                            break;
                        } else if ((!(((_x983)._right8) == null)) && (true)) {
                            _descend984 = true;
                            if ((_x983) == (_root982)) {
                                _root982 = (_x983)._right8;
                            }
                            _x983 = (_x983)._right8;
                        } else if ((_x983) == (_root982)) {
                            _x983 = null;
                            break;
                        } else {
                            _descend984 = false;
                            _from_left985 = (!(((_x983)._parent9) == null)) && ((_x983) == (((_x983)._parent9)._left7));
                            _x983 = (_x983)._parent9;
                        }
                    } else {
                        if ((_x983) == (_root982)) {
                            _x983 = null;
                            break;
                        } else {
                            _descend984 = false;
                            _from_left985 = (!(((_x983)._parent9) == null)) && ((_x983) == (((_x983)._parent9)._left7));
                            _x983 = (_x983)._parent9;
                        }
                    }
                }
                _new_x981 = _x983;
                var _mp986 = (_x983)._parent9;
                var _mr987 = (_x983)._right8;
                /* replace _x983 with _mr987 in _mp986 */
                if (!((_mp986) == null)) {
                    if (((_mp986)._left7) == (_x983)) {
                        (_mp986)._left7 = _mr987;
                    } else {
                        (_mp986)._right8 = _mr987;
                    }
                }
                if (!((_mr987) == null)) {
                    (_mr987)._parent9 = _mp986;
                }
                /* replace _to_remove977 with _x983 in _parent978 */
                if (!((_parent978) == null)) {
                    if (((_parent978)._left7) == (_to_remove977)) {
                        (_parent978)._left7 = _x983;
                    } else {
                        (_parent978)._right8 = _x983;
                    }
                }
                if (!((_x983) == null)) {
                    (_x983)._parent9 = _parent978;
                }
                /* replace null with _left979 in _x983 */
                (_x983)._left7 = _left979;
                if (!((_left979) == null)) {
                    (_left979)._parent9 = _x983;
                }
                /* replace _mr987 with (_to_remove977)._right8 in _x983 */
                (_x983)._right8 = (_to_remove977)._right8;
                if (!(((_to_remove977)._right8) == null)) {
                    ((_to_remove977)._right8)._parent9 = _x983;
                }
                /* _min_ax12 is min of ax1 */
                var _augval988 = (_x983).ax1;
                var _child989 = (_x983)._left7;
                if (!((_child989) == null)) {
                    var _val990 = (_child989)._min_ax12;
                    _augval988 = ((_augval988) < (_val990)) ? (_augval988) : (_val990);
                }
                var _child991 = (_x983)._right8;
                if (!((_child991) == null)) {
                    var _val992 = (_child991)._min_ax12;
                    _augval988 = ((_augval988) < (_val992)) ? (_augval988) : (_val992);
                }
                (_x983)._min_ax12 = _augval988;
                /* _min_ay13 is min of ay1 */
                var _augval993 = (_x983).ay1;
                var _child994 = (_x983)._left7;
                if (!((_child994) == null)) {
                    var _val995 = (_child994)._min_ay13;
                    _augval993 = ((_augval993) < (_val995)) ? (_augval993) : (_val995);
                }
                var _child996 = (_x983)._right8;
                if (!((_child996) == null)) {
                    var _val997 = (_child996)._min_ay13;
                    _augval993 = ((_augval993) < (_val997)) ? (_augval993) : (_val997);
                }
                (_x983)._min_ay13 = _augval993;
                /* _max_ay24 is max of ay2 */
                var _augval998 = (_x983).ay2;
                var _child999 = (_x983)._left7;
                if (!((_child999) == null)) {
                    var _val1000 = (_child999)._max_ay24;
                    _augval998 = ((_augval998) < (_val1000)) ? (_val1000) : (_augval998);
                }
                var _child1001 = (_x983)._right8;
                if (!((_child1001) == null)) {
                    var _val1002 = (_child1001)._max_ay24;
                    _augval998 = ((_augval998) < (_val1002)) ? (_val1002) : (_augval998);
                }
                (_x983)._max_ay24 = _augval998;
                (_x983)._height10 = 1 + ((((((_x983)._left7) == null) ? (-1) : (((_x983)._left7)._height10)) > ((((_x983)._right8) == null) ? (-1) : (((_x983)._right8)._height10))) ? ((((_x983)._left7) == null) ? (-1) : (((_x983)._left7)._height10)) : ((((_x983)._right8) == null) ? (-1) : (((_x983)._right8)._height10)));
                var _cursor1003 = _mp986;
                var _changed1004 = true;
                while ((_changed1004) && (!((_cursor1003) == (_parent978)))) {
                    var _old__min_ax121005 = (_cursor1003)._min_ax12;
                    var _old__min_ay131006 = (_cursor1003)._min_ay13;
                    var _old__max_ay241007 = (_cursor1003)._max_ay24;
                    var _old_height1008 = (_cursor1003)._height10;
                    /* _min_ax12 is min of ax1 */
                    var _augval1009 = (_cursor1003).ax1;
                    var _child1010 = (_cursor1003)._left7;
                    if (!((_child1010) == null)) {
                        var _val1011 = (_child1010)._min_ax12;
                        _augval1009 = ((_augval1009) < (_val1011)) ? (_augval1009) : (_val1011);
                    }
                    var _child1012 = (_cursor1003)._right8;
                    if (!((_child1012) == null)) {
                        var _val1013 = (_child1012)._min_ax12;
                        _augval1009 = ((_augval1009) < (_val1013)) ? (_augval1009) : (_val1013);
                    }
                    (_cursor1003)._min_ax12 = _augval1009;
                    /* _min_ay13 is min of ay1 */
                    var _augval1014 = (_cursor1003).ay1;
                    var _child1015 = (_cursor1003)._left7;
                    if (!((_child1015) == null)) {
                        var _val1016 = (_child1015)._min_ay13;
                        _augval1014 = ((_augval1014) < (_val1016)) ? (_augval1014) : (_val1016);
                    }
                    var _child1017 = (_cursor1003)._right8;
                    if (!((_child1017) == null)) {
                        var _val1018 = (_child1017)._min_ay13;
                        _augval1014 = ((_augval1014) < (_val1018)) ? (_augval1014) : (_val1018);
                    }
                    (_cursor1003)._min_ay13 = _augval1014;
                    /* _max_ay24 is max of ay2 */
                    var _augval1019 = (_cursor1003).ay2;
                    var _child1020 = (_cursor1003)._left7;
                    if (!((_child1020) == null)) {
                        var _val1021 = (_child1020)._max_ay24;
                        _augval1019 = ((_augval1019) < (_val1021)) ? (_val1021) : (_augval1019);
                    }
                    var _child1022 = (_cursor1003)._right8;
                    if (!((_child1022) == null)) {
                        var _val1023 = (_child1022)._max_ay24;
                        _augval1019 = ((_augval1019) < (_val1023)) ? (_val1023) : (_augval1019);
                    }
                    (_cursor1003)._max_ay24 = _augval1019;
                    (_cursor1003)._height10 = 1 + ((((((_cursor1003)._left7) == null) ? (-1) : (((_cursor1003)._left7)._height10)) > ((((_cursor1003)._right8) == null) ? (-1) : (((_cursor1003)._right8)._height10))) ? ((((_cursor1003)._left7) == null) ? (-1) : (((_cursor1003)._left7)._height10)) : ((((_cursor1003)._right8) == null) ? (-1) : (((_cursor1003)._right8)._height10)));
                    _changed1004 = false;
                    _changed1004 = (_changed1004) || (!((_old__min_ax121005) == ((_cursor1003)._min_ax12)));
                    _changed1004 = (_changed1004) || (!((_old__min_ay131006) == ((_cursor1003)._min_ay13)));
                    _changed1004 = (_changed1004) || (!((_old__max_ay241007) == ((_cursor1003)._max_ay24)));
                    _changed1004 = (_changed1004) || (!((_old_height1008) == ((_cursor1003)._height10)));
                    _cursor1003 = (_cursor1003)._parent9;
                }
            }
            var _cursor1024 = _parent978;
            var _changed1025 = true;
            while ((_changed1025) && (!((_cursor1024) == (null)))) {
                var _old__min_ax121026 = (_cursor1024)._min_ax12;
                var _old__min_ay131027 = (_cursor1024)._min_ay13;
                var _old__max_ay241028 = (_cursor1024)._max_ay24;
                var _old_height1029 = (_cursor1024)._height10;
                /* _min_ax12 is min of ax1 */
                var _augval1030 = (_cursor1024).ax1;
                var _child1031 = (_cursor1024)._left7;
                if (!((_child1031) == null)) {
                    var _val1032 = (_child1031)._min_ax12;
                    _augval1030 = ((_augval1030) < (_val1032)) ? (_augval1030) : (_val1032);
                }
                var _child1033 = (_cursor1024)._right8;
                if (!((_child1033) == null)) {
                    var _val1034 = (_child1033)._min_ax12;
                    _augval1030 = ((_augval1030) < (_val1034)) ? (_augval1030) : (_val1034);
                }
                (_cursor1024)._min_ax12 = _augval1030;
                /* _min_ay13 is min of ay1 */
                var _augval1035 = (_cursor1024).ay1;
                var _child1036 = (_cursor1024)._left7;
                if (!((_child1036) == null)) {
                    var _val1037 = (_child1036)._min_ay13;
                    _augval1035 = ((_augval1035) < (_val1037)) ? (_augval1035) : (_val1037);
                }
                var _child1038 = (_cursor1024)._right8;
                if (!((_child1038) == null)) {
                    var _val1039 = (_child1038)._min_ay13;
                    _augval1035 = ((_augval1035) < (_val1039)) ? (_augval1035) : (_val1039);
                }
                (_cursor1024)._min_ay13 = _augval1035;
                /* _max_ay24 is max of ay2 */
                var _augval1040 = (_cursor1024).ay2;
                var _child1041 = (_cursor1024)._left7;
                if (!((_child1041) == null)) {
                    var _val1042 = (_child1041)._max_ay24;
                    _augval1040 = ((_augval1040) < (_val1042)) ? (_val1042) : (_augval1040);
                }
                var _child1043 = (_cursor1024)._right8;
                if (!((_child1043) == null)) {
                    var _val1044 = (_child1043)._max_ay24;
                    _augval1040 = ((_augval1040) < (_val1044)) ? (_val1044) : (_augval1040);
                }
                (_cursor1024)._max_ay24 = _augval1040;
                (_cursor1024)._height10 = 1 + ((((((_cursor1024)._left7) == null) ? (-1) : (((_cursor1024)._left7)._height10)) > ((((_cursor1024)._right8) == null) ? (-1) : (((_cursor1024)._right8)._height10))) ? ((((_cursor1024)._left7) == null) ? (-1) : (((_cursor1024)._left7)._height10)) : ((((_cursor1024)._right8) == null) ? (-1) : (((_cursor1024)._right8)._height10)));
                _changed1025 = false;
                _changed1025 = (_changed1025) || (!((_old__min_ax121026) == ((_cursor1024)._min_ax12)));
                _changed1025 = (_changed1025) || (!((_old__min_ay131027) == ((_cursor1024)._min_ay13)));
                _changed1025 = (_changed1025) || (!((_old__max_ay241028) == ((_cursor1024)._max_ay24)));
                _changed1025 = (_changed1025) || (!((_old_height1029) == ((_cursor1024)._height10)));
                _cursor1024 = (_cursor1024)._parent9;
            }
            if (((this)._root1) == (_to_remove977)) {
                (this)._root1 = _new_x981;
            }
            _prev_cursor5 = null;
        }
    };
}
; 
 
 buildViz = function (d3) {
    return function (widthInPixels = 1000,
                     heightInPixels = 600,
                     max_snippets = null,
                     color = null,
                     sortByDist = true,
                     useFullDoc = false,
                     greyZeroScores = false,
                     asianMode = false,
                     nonTextFeaturesMode = false,
                     showCharacteristic = true,
                     wordVecMaxPValue = false,
                     saveSvgButton = false,
                     reverseSortScoresForNotCategory = false,
                     minPVal = 0.1,
                     pValueColors = false,
                     xLabelText = null,
                     yLabelText = null,
                     fullData = null,
                     showTopTerms = true,
                     showNeutral = false,
                     getTooltipContent = null,
                     xAxisValues = null,
                     yAxisValues = null,
                     colorFunc = null,
                     showAxes = true,
                     showExtra = false,
                     doCensorPoints = true,
                     centerLabelsOverPoints = false,
                     xAxisLabels = null,
                     yAxisLabels = null,
                     topic_model_preview_size=10,
                     verticalLines = null,
                     horizontal_line_y_position = null,
                     vertical_line_x_position = null,
                     unifiedContexts = false,
                     showCategoryHeadings = true,
                     showCrossAxes = true,
                     divName = 'd3-div-1',
                     alternativeTermFunc = null,
                     includeAllContexts = false) {
        //var divName = 'd3-div-1';
        // Set the dimensions of the canvas / graph
        var padding = {top: 30, right: 20, bottom: 30, left: 50};
        if (!showAxes) {
            padding = {top: 30, right: 20, bottom: 30, left: 50};
        }
        var margin = padding,
            width = widthInPixels - margin.left - margin.right,
            height = heightInPixels - margin.top - margin.bottom;
        fullData.data.forEach(function (x, i) {x.i = i});
        
        // Set the ranges
        var x = d3.scaleLinear().range([0, width]);
        var y = d3.scaleLinear().range([height, 0]);

        if (unifiedContexts) {
            document.querySelectorAll('#'+divName+'-'+'notcol')
                .forEach(function (x) {x.style.display = 'none'});
            document.querySelectorAll('.'+divName+'-'+'contexts')
                .forEach(function (x) {x.style.width = '90%'});
        } 
        else if (showNeutral) {
            if (showExtra) {
                document.querySelectorAll('.'+divName+'-'+'contexts')
                .forEach(function (x) {
                    x.style.width = '25%'
                    x.style.float = 'left'
                });

                ['notcol','neutcol','extracol'].forEach(function (columnName) { 
                    document.querySelectorAll('#'+divName+'-'+columnName)
                        .forEach(function (x) {
                            x.style.display = 'inline'
                            x.style.float = 'left'
                            x.style.width = '25%'
                        });
                })

            } else {
                document.querySelectorAll('.'+divName+'-'+'contexts')
                .forEach(function (x) {
                    x.style.width = '33%'
                    x.style.float = 'left'
                });

                ['notcol','neutcol'].forEach(function (columnName) { 
                    document.querySelectorAll('#'+divName+'-'+columnName)
                        .forEach(function (x) {
                            x.style.display = 'inline'
                            x.style.float = 'left'
                            x.style.width = '33%'
                        });
                })


            }
        } else {
            document.querySelectorAll('.'+divName+'-'+'contexts')
                .forEach(function (x) {
                    x.style.width = '45%'
                    //x.style.display = 'inline'
                    x.style.float = 'left'
                });

            ['notcol'].forEach(function (columnName) { 
                document.querySelectorAll('#'+divName+'-'+columnName)
                    .forEach(function (x) {
                        //x.style.display = 'inline'
                        x.style.float = 'left'
                        x.style.width = '45%'
                    });
            })
        }

        var yAxis = null;
        var xAxis = null;

        function axisLabelerFactory(axis) {
            if ((axis == "x" && xLabelText == null)
                || (axis == "y" && yLabelText == null))
                return function (d, i) {
                    return ["Infrequent", "Average", "Frequent"][i];
                };

            return function (d, i) {
                return ["Low", "Medium", "High"][i];
            }
        }


        function bs(ar, x) {
            function bsa(s, e) {
                var mid = Math.floor((s + e) / 2);
                var midval = ar[mid];
                if (s == e) {
                    return s;
                }
                if (midval == x) {
                    return mid;
                } else if (midval < x) {
                    return bsa(mid + 1, e);
                } else {
                    return bsa(s, mid);
                }
            }

            return bsa(0, ar.length);
        }
        

        console.log("fullData");
        console.log(fullData);

        
        var sortedX = fullData.data.map(x=>x).sort(function (a, b) {
            return a.x < b.x ? -1 : (a.x == b.x ? 0 : 1);
        }).map(function (x) {
            return x.x
        });

        var sortedOx = fullData.data.map(x=>x).sort(function (a, b) {
            return a.ox < b.ox ? -1 : (a.ox == b.ox ? 0 : 1);
        }).map(function (x) {
            return x.ox
        });

        var sortedY = fullData.data.map(x=>x).sort(function (a, b) {
            return a.y < b.y ? -1 : (a.y == b.y ? 0 : 1);
        }).map(function (x) {
            return x.y
        });

        var sortedOy = fullData.data.map(x=>x).sort(function (a, b) {
            return a.oy < b.oy ? -1 : (a.oy == b.oy ? 0 : 1);
        }).map(function (x) {
            return x.oy
        });
        console.log("444");
        console.log(fullData.data[0])


        function labelWithZScore(axis, axisName, tickPoints) {
            var myVals = axisName === 'x' ? sortedOx : sortedOy;
            var myPlotedVals = axisName === 'x' ? sortedX : sortedY;
            var ticks = tickPoints.map(function (x) {
                return myPlotedVals[bs(myVals, x)]
            });
            return axis.tickValues(ticks).tickFormat(
                function (d, i) {
                    return tickPoints[i];
                })
        }

        if (xAxisValues) {
            xAxis = labelWithZScore(d3.axisBottom(x), 'x', xAxisValues);
        } else if (xAxisLabels) {
            xAxis = d3.axisBottom(x)
                .ticks(xAxisLabels.length)
                .tickFormat(function (d, i) {
                    return xAxisLabels[i];
                });
        } else {
            xAxis = d3.axisBottom(x).ticks(3).tickFormat(axisLabelerFactory('x'));
        }
        if (yAxisValues) {
            yAxis = labelWithZScore(d3.axisLeft(y), 'y', yAxisValues);
        } else if (yAxisLabels) {
            yAxis = d3.axisLeft(y)
                .ticks(yAxisLabels.length)
                .tickFormat(function (d, i) {
                    return yAxisLabels[i];
                });
        } else {
            yAxis = d3.axisLeft(y).ticks(3).tickFormat(axisLabelerFactory('y'));
        }

        // var label = d3.select("body").append("div")
        var label = d3.select('#' + divName).append("div")
            .attr("class", "label");


        var interpolateLightGreys = d3.interpolate(d3.rgb(230, 230, 230),
            d3.rgb(130, 130, 130));
        // setup fill color
        if (color == null) {
            color = d3.interpolateRdYlBu;
            //color = d3.interpolateWarm;
        }

        var pixelsToAddToWidth = 200;
        if (!showTopTerms && !showCharacteristic) {
            pixelsToAddToWidth = 0;
        }

        // Adds the svg canvas
        // var svg = d3.select("body")
        svg = d3.select('#' + divName)
            .append("svg")
            .attr("width", width + margin.left + margin.right + pixelsToAddToWidth)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform",
                "translate(" + margin.left + "," + margin.top + ")");


        origSVGLeft = svg.node().getBoundingClientRect().left;
        origSVGTop = svg.node().getBoundingClientRect().top;
        var lastCircleSelected = null;

        function getCorpusWordCounts() {
            var binaryLabels = fullData.docs.labels.map(function (label) {
                return 1 * (fullData.docs.categories[label] != fullData.info.category_internal_name);
            });
            var wordCounts = {}; // word -> [cat counts, not-cat-counts]
            var wordCountSums = [0, 0];
            fullData.docs.texts.forEach(function (text, i) {
                text.toLowerCase().trim().split(/\W+/).forEach(function (word) {
                    if (word.trim() !== '') {
                        if (!(word in wordCounts))
                            wordCounts[word] = [0, 0];
                        wordCounts[word][binaryLabels[i]]++;
                        wordCountSums[binaryLabels[i]]++;
                    }
                })
            });
            return {
                avgDocLen: (wordCountSums[0] + wordCountSums[1]) / fullData.docs.texts.length,
                counts: wordCounts,
                sums: wordCountSums,
                uniques: [[0, 0]].concat(Object.keys(wordCounts).map(function (key) {
                    return wordCounts[key];
                })).reduce(function (a, b) {
                    return [a[0] + (b[0] > 0), a[1] + (b[1] > 0)]
                })
            };
        }

        function getContextWordCounts(query) {
            var wordCounts = {};
            var wordCountSums = [0, 0];
            var priorCountSums = [0, 0];
            gatherTermContexts(termDict[query])
                .contexts
                .forEach(function (contextSet, categoryIdx) {
                    contextSet.forEach(function (context) {
                        context.snippets.forEach(function (snippet) {
                            var tokens = snippet.toLowerCase().trim().replace('<b>', '').replace('</b>', '').split(/\W+/);
                            var matchIndices = [];
                            tokens.forEach(function (word, i) {
                                if (word === query) matchIndices.push(i)
                            });
                            tokens.forEach(function (word, i) {
                                if (word.trim() !== '') {
                                    var isValid = false;
                                    for (var matchI in matchIndices) {
                                        if (Math.abs(i - matchI) < 3) {
                                            isValid = true;
                                            break
                                        }
                                    }
                                    if (isValid) {
                                        //console.log([word, i, matchI, isValid]);
                                        if (!(word in wordCounts)) {
                                            var priorCounts = corpusWordCounts.counts[word]
                                            wordCounts[word] = [0, 0].concat(priorCounts);
                                            priorCountSums[0] += priorCounts[0];
                                            priorCountSums[1] += priorCounts[1];
                                        }
                                        wordCounts[word][categoryIdx]++;
                                        wordCountSums[categoryIdx]++;
                                    }
                                }
                            })
                        })
                    })
                });
            return {
                counts: wordCounts,
                priorSums: priorCountSums,
                sums: wordCountSums,
                uniques: [[0, 0]].concat(Object.keys(wordCounts).map(function (key) {
                    return wordCounts[key];
                })).reduce(function (a, b) {
                    return [a[0] + (b[0] > 0), a[1] + (b[1] > 0)];
                })
            }

        }
        
        function denseRank(ar) {
            var markedAr = ar.map((x,i) => [x,i]).sort((a,b) => a[0] - b[0]);
            var curRank = 1
            var rankedAr = markedAr.map(
                function(x, i) {
                    if(i > 0 && x[0] != markedAr[i-1][0]) {
                        curRank++;
                    }
                    return [curRank, x[0], x[1]];
                }
            )
            return rankedAr.map(x=>x).sort((a,b) => (a[2] - b[2])).map(x => x[0]);    
        }
        
        
        function getDenseRanks(fullData, categoryNum) {
            var fgFreqs = Array(fullData.data.length).fill(0);
            var bgFreqs = Array(fullData.data.length).fill(0);
            var categoryTermCounts = fullData.termCounts[categoryNum];
            
            
            Object.keys(categoryTermCounts).forEach(
                key => fgFreqs[key] = categoryTermCounts[key][0]
            )
            fullData.termCounts.forEach( 
                function (categoryTermCounts, otherCategoryNum) {
                    if(otherCategoryNum != categoryNum) {
                        Object.keys(categoryTermCounts).forEach(
                           key => bgFreqs[key] += categoryTermCounts[key][0]
                        )                        
                    }
                }
            )
            var fgDenseRanks = denseRank(fgFreqs);
            var bgDenseRanks = denseRank(bgFreqs);
            
            var maxfgDenseRanks = Math.max(...fgDenseRanks);
            var minfgDenseRanks = Math.min(...fgDenseRanks);
            var scalefgDenseRanks = fgDenseRanks.map(
                x => (x - minfgDenseRanks)/(maxfgDenseRanks - minfgDenseRanks)
            )

            var maxbgDenseRanks = Math.max(...bgDenseRanks);
            var minbgDenseRanks = Math.min(...bgDenseRanks);
            var scalebgDenseRanks = bgDenseRanks.map(
                x => (x - minbgDenseRanks)/(maxbgDenseRanks - minbgDenseRanks)
            )

            return {'fg': scalefgDenseRanks, 'bg': scalebgDenseRanks, 'bgFreqs': bgFreqs, 'fgFreqs': fgFreqs}
        }

        function getCategoryDenseRankScores(fullData, categoryNum) {
            var denseRanks = getDenseRanks(fullData, categoryNum)
            return denseRanks.fg.map((x,i) => x - denseRanks.bg[i]);
        }
        
        function getTermCounts(fullData) {
            var counts = Array(fullData.data.length).fill(0);  
            fullData.termCounts.forEach( 
                function (categoryTermCounts) {
                    Object.keys(categoryTermCounts).forEach(
                       key => counts[key] = categoryTermCounts[key][0]
                    )                        
                }
            )
            return counts;
        }
        
        function getContextWordLORIPs(query) {
            var contextWordCounts = getContextWordCounts(query);
            var ni_k = contextWordCounts.sums[0];
            var nj_k = contextWordCounts.sums[1];
            var n = ni_k + nj_k;
            //var ai_k0 = contextWordCounts.priorSums[0] + contextWordCounts.priorSums[1];
            //var aj_k0 = contextWordCounts.priorSums[0] + contextWordCounts.priorSums[1];
            var a0 = 0.00001 //corpusWordCounts.avgDocLen;
            var a_k0 = Object.keys(contextWordCounts.counts)
                .map(function (x) {
                    var counts = contextWordCounts.counts[x];
                    return a0 * (counts[2] + counts[3]) /
                        (contextWordCounts.priorSums[0] + contextWordCounts.priorSums[1]);
                })
                .reduce(function (a, b) {
                    return a + b
                });
            var ai_k0 = a_k0 / ni_k;
            var aj_k0 = a_k0 / nj_k;
            var scores = Object.keys(contextWordCounts.counts).map(
                function (word) {
                    var countData = contextWordCounts.counts[word];
                    var yi = countData[0];
                    var yj = countData[1];
                    //var ai = countData[2];
                    //var aj = countData[3];
                    //var ai = countData[2] + countData[3];
                    //var aj = ai;
                    //var ai = (countData[2] + countData[3]) * a0/ni_k;
                    //var aj = (countData[2] + countData[3]) * a0/nj_k;
                    var ai = a0 * (countData[2] + countData[3]) /
                        (contextWordCounts.priorSums[0] + contextWordCounts.priorSums[1]);
                    var aj = ai;
                    var deltahat_i_j =
                        +Math.log((yi + ai) * 1. / (ni_k + ai_k0 - yi - ai))
                        - Math.log((yj + aj) * 1. / (nj_k + aj_k0 - yj - aj));
                    var var_deltahat_i_j = 1. / (yi + ai) + 1. / (ni_k + ai_k0 - yi - ai)
                        + 1. / (yj + aj) + 1. / (nj_k + aj_k0 - yj - aj);
                    var zeta_ij = deltahat_i_j / Math.sqrt(var_deltahat_i_j);
                    return [word, yi, yj, ai, aj, ai_k0, zeta_ij];
                }
            ).sort(function (a, b) {
                return b[5] - a[5];
            });
            return scores;
        }

        function getContextWordSFS(query) {
            // from https://stackoverflow.com/questions/14846767/std-normal-cdf-normal-cdf-or-error-function
            function cdf(x, mean, variance) {
                return 0.5 * (1 + erf((x - mean) / (Math.sqrt(2 * variance))));
            }

            function erf(x) {
                // save the sign of x
                var sign = (x >= 0) ? 1 : -1;
                x = Math.abs(x);

                // constants
                var a1 = 0.254829592;
                var a2 = -0.284496736;
                var a3 = 1.421413741;
                var a4 = -1.453152027;
                var a5 = 1.061405429;
                var p = 0.3275911;

                // A&S formula 7.1.26
                var t = 1.0 / (1.0 + p * x);
                var y = 1.0 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * Math.exp(-x * x);
                return sign * y; // erf(-x) = -erf(x);
            }

            function scale(a) {
                return Math.log(a + 0.0000001);
            }

            var contextWordCounts = getContextWordCounts(query);
            var wordList = Object.keys(contextWordCounts.counts).map(function (word) {
                return contextWordCounts.counts[word].concat([word]);
            });
            var cat_freq_xbar = wordList.map(function (x) {
                return scale(x[0])
            }).reduce(function (a, b) {
                return a + b
            }) / wordList.length;
            var cat_freq_var = wordList.map(function (x) {
                return Math.pow((scale(x[0]) - cat_freq_xbar), 2);
            }).reduce(function (a, b) {
                return a + b
            }) / wordList.length;
            var cat_prec_xbar = wordList.map(function (x) {
                return scale(x[0] / (x[0] + x[1]));
            }).reduce(function (a, b) {
                return a + b
            }) / wordList.length;
            var cat_prec_var = wordList.map(function (x) {
                return Math.pow((scale(x[0] / (x[0] + x[1])) - cat_prec_xbar), 2);
            }).reduce(function (a, b) {
                return a + b
            }) / wordList.length;

            var ncat_freq_xbar = wordList.map(function (x) {
                return scale(x[0])
            }).reduce(function (a, b) {
                return a + b
            }) / wordList.length;
            var ncat_freq_var = wordList.map(function (x) {
                return Math.pow((scale(x[0]) - ncat_freq_xbar), 2);
            }).reduce(function (a, b) {
                return a + b
            }) / wordList.length;
            var ncat_prec_xbar = wordList.map(function (x) {
                return scale(x[0] / (x[0] + x[1]));
            }).reduce(function (a, b) {
                return a + b
            }) / wordList.length;
            var ncat_prec_var = wordList.map(function (x) {
                return Math.pow((scale(x[0] / (x[0] + x[1])) - ncat_prec_xbar), 2);
            }).reduce(function (a, b) {
                return a + b
            }) / wordList.length;

            function scaledFScore(cnt, other, freq_xbar, freq_var, prec_xbar, prec_var) {
                var beta = 1.5;
                var normFreq = cdf(scale(cnt), freq_xbar, freq_var);
                var normPrec = cdf(scale(cnt / (cnt + other)), prec_xbar, prec_var);
                return (1 + Math.pow(beta, 2)) * normFreq * normPrec / (Math.pow(beta, 2) * normFreq + normPrec);
            }

            var sfs = wordList.map(function (x) {
                cat_sfs = scaledFScore(x[0], x[1], cat_freq_xbar,
                    cat_freq_var, cat_prec_xbar, cat_prec_var);
                ncat_sfs = scaledFScore(x[1], x[0], ncat_freq_xbar,
                    ncat_freq_var, ncat_prec_xbar, ncat_prec_var);
                return [cat_sfs > ncat_sfs ? cat_sfs : -ncat_sfs].concat(x);

            }).sort(function (a, b) {
                return b[0] - a[0];
            });
            return sfs;
        }

        function deselectLastCircle() {
            if (lastCircleSelected) {
                lastCircleSelected.style["stroke"] = null;
                lastCircleSelected = null;
            }
        }

        function getSentenceBoundaries(text) {
            // !!! need to use spacy's sentence splitter
            if (asianMode) {
                var sentenceRe = /\n/gmi;
            } else {
                var sentenceRe = /\(?[^\.\?\!\n\b]+[\n\.!\?]\)?/g;
            }
            var offsets = [];
            var match;
            while ((match = sentenceRe.exec(text)) != null) {
                offsets.push(match.index);
            }
            offsets.push(text.length);
            return offsets;
        }

        function getMatchingSnippet(text, boundaries, start, end) {
            var sentenceStart = null;
            var sentenceEnd = null;
            for (var i in boundaries) {
                var position = boundaries[i];
                if (position <= start && (sentenceStart == null || position > sentenceStart)) {
                    sentenceStart = position;
                }
                if (position >= end) {
                    sentenceEnd = position;
                    break;
                }
            }
            var snippet = (text.slice(sentenceStart, start) + "<b>" + text.slice(start, end)
                + "</b>" + text.slice(end, sentenceEnd)).trim();
            if (sentenceStart == null) {
                sentenceStart = 0;
            }
            return {'snippet': snippet, 'sentenceStart': sentenceStart};
        }

        function gatherTermContexts(d, includeAll = true) {
            var category_name = fullData['info']['category_name'];
            var not_category_name = fullData['info']['not_category_name'];
            var matches = [[], [], [], []];
            console.log("searching")

            if (fullData.docs === undefined) return matches;
            if (!nonTextFeaturesMode) {
                return searchInText(d, includeAll);
            } else {
                return searchInExtraFeatures(d, includeAll);
            }
        }

        function searchInExtraFeatures(d) {
            var matches = [[], [], [], []];
            var term = d.term;
            var categoryNum = fullData.docs.categories.indexOf(fullData.info.category_internal_name);
            var notCategoryNumList = fullData.docs.categories.map(function (x, i) {
                if (fullData.info.not_category_internal_names.indexOf(x) > -1) {
                    return i;
                } else {
                    return -1;
                }
            }).filter(function (x) {
                return x > -1
            });
            var neutralCategoryNumList = fullData.docs.categories.map(function (x, i) {
                if (fullData.info.neutral_category_internal_names.indexOf(x) > -1) {
                    return i;
                } else {
                    return -1;
                }
            }).filter(function (x) {
                return x > -1
            });
            var extraCategoryNumList = fullData.docs.categories.map(function (x, i) {
                if (fullData.info.extra_category_internal_names.indexOf(x) > -1) {
                    return i;
                } else {
                    return -1;
                }
            }).filter(function (x) {
                return x > -1
            });

            var pattern = null;
            if ('metalists' in fullData && term in fullData.metalists) {
                // from https://stackoverflow.com/questions/3446170/escape-string-for-use-in-javascript-regex
                function escapeRegExp(str) {
                    return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|\']/g, "\\$&");
                }

                console.log('term');
                console.log(term);
                pattern = new RegExp(
                    '\\W(' + fullData.metalists[term].map(escapeRegExp).join('|') + ')\\W',
                    'gim'
                );
            }

            for (var i in fullData.docs.extra) {
                if (term in fullData.docs.extra[i]) {
                    var strength = fullData.docs.extra[i][term] /
                        Object.values(fullData.docs.extra[i]).reduce(
                            function (a, b) {
                                return a + b
                            });

                    var docLabel = fullData.docs.labels[i];
                    var numericLabel = -1;
                    if (docLabel == categoryNum) {
                        numericLabel = 0;
                    } else if (notCategoryNumList.indexOf(docLabel) > -1) {
                        numericLabel = 1;
                    } else if (neutralCategoryNumList.indexOf(docLabel) > -1) {
                        numericLabel = 2;
                    } else if (extraCategoryNumList.indexOf(docLabel) > -1) {
                        numericLabel = 3;
                    }
                    if (numericLabel == -1) {
                        continue;
                    }
                    var text = fullData.docs.texts[i];
                    if (!useFullDoc)
                        text = text.slice(0, 300);
                    if (pattern !== null) {
                        text = text.replace(pattern, '<b>$&</b>');
                    }
                    var curMatch = {
                        'id': i,
                        'snippets': [text],
                        'strength': strength,
                        'docLabel': docLabel,
                        'meta': fullData.docs.meta ? fullData.docs.meta[i] : ""
                    }

                    matches[numericLabel].push(curMatch);
                }
            }
            for (var i in [0, 1]) {
                matches[i] = matches[i].sort(function (a, b) {
                    return a.strength < b.strength ? 1 : -1
                })
            }
            return {'contexts': matches, 'info': d};
        }

        // from https://mathiasbynens.be/notes/es-unicode-property-escapes#emoji
        var emojiRE = (/(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC69\uDC6E\uDC70-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD18-\uDD1C\uDD1E\uDD1F\uDD26\uDD30-\uDD39\uDD3D\uDD3E\uDDD1-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])?|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDEEB\uDEEC\uDEF4-\uDEF8]|\uD83E[\uDD10-\uDD3A\uDD3C-\uDD3E\uDD40-\uDD45\uDD47-\uDD4C\uDD50-\uDD6B\uDD80-\uDD97\uDDC0\uDDD0-\uDDE6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u2660\u2663\u2665\u2666\u2668\u267B\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEF8]|\uD83E[\uDD10-\uDD3A\uDD3C-\uDD3E\uDD40-\uDD45\uDD47-\uDD4C\uDD50-\uDD6B\uDD80-\uDD97\uDDC0\uDDD0-\uDDE6])\uFE0F/g);

        function isEmoji(str) {
            if (str.match(emojiRE)) return true;
            return false;
        }

        function displayObscuredTerms(obscuredTerms, data, term, termInfo, div='#'+divName+'-'+'overlapped-terms') {
            d3.select('#'+divName+'-'+'overlapped-terms')
                .selectAll('div')
                .remove();
            d3.select(div)
                .selectAll('div')
                .remove();
            if (obscuredTerms.length > 1) {
                var obscuredDiv = d3.select(div)
                    .append('div')
                    .attr("class", "obscured")
                    .style('align', 'center')
                    .style('text-align', 'center')
                    .html("<b>\"" + term + "\" obstructs</b>: ");
                obscuredTerms.map(
                    function (term, i) {
                        makeWordInteractive(
                            data,
                            svg,
                            obscuredDiv.append("text").text(term),
                            term,
                            data.filter(t=>t.term == term)[0],//termInfo
                            false
                        );
                        if (i < obscuredTerms.length - 1) {
                            obscuredDiv.append("text").text(", ");
                        }
                    }
                )
            }
        }

        function displayTermContexts(data, termInfo, jump=true, includeAll = false) {
            var contexts = termInfo.contexts;
            var info = termInfo.info;
            var notmatches = termInfo.notmatches;
            if (contexts[0].length + contexts[1].length + contexts[2].length + contexts[3].length == 0) {
                return null;
            }
            //!!! Future feature: context words
            //var contextWords = getContextWordSFS(info.term);
            //var contextWords = getContextWordLORIPs(info.term);
            //var categoryNames = [fullData.info.category_name,
            //    fullData.info.not_category_name];
            var catInternalName = fullData.info.category_internal_name;


            function addSnippets(contexts, divId, isMatch=true) {
                var meta = contexts.meta ? contexts.meta : '&nbsp;';
                var headClass = 'snippet_meta docLabel' + contexts.docLabel;
                var snippetClass = 'snippet docLabel' + contexts.docLabel;
                if(!isMatch) {
                    headClass = 'snippet_meta not_match docLabel' + contexts.docLabel;
                    snippetClass = 'snippet not_match docLabel' + contexts.docLabel;
                }
                d3.select(divId)
                    .append("div")
                    .attr('class', headClass)
                    .html(meta);
                contexts.snippets.forEach(function (snippet) {
                    d3.select(divId)
                        .append("div")
                        .attr('class', snippetClass)
                        .html(snippet);
                })
            }
            if (unifiedContexts) {
               divId = '#'+divName+'-'+'cat';
                var docLabelCounts = fullData.docs.labels.reduce(
                    function(map, label) {map[label] = (map[label]||0)+1; return map;},
                    Object.create(null)
                );
               var numMatches = Object.create(null);
               var temp = d3.select(divId).selectAll("div").remove();
               var allContexts = contexts[0].concat(contexts[1]).concat(contexts[2]).concat(contexts[3]);
               allContexts.forEach(function (singleDoc) {
                    numMatches[singleDoc.docLabel] = (numMatches[singleDoc.docLabel]||0) + 1;
               });
               var allNotMatches = notmatches[0].concat(notmatches[1]).concat(notmatches[2]).concat(notmatches[3]);
                
               /*contexts.forEach(function(context) {
                    context.forEach(function (singleDoc) {
                        numMatches[singleDoc.docLabel] = (numMatches[singleDoc.docLabel]||0) + 1;
                        addSnippets(singleDoc, divId);
                    });
                });*/
                var docLabelCountsSorted = Object.keys(docLabelCounts).map(key => (
                    {"label": fullData.docs.categories[key],
                     "labelNum": key,
                     "matches": numMatches[key]||0,
                     "overall": docLabelCounts[key],
                     'percent': (numMatches[key]||0)*100./docLabelCounts[key]}))
                    .sort(function(a,b) {return b.percent-a.percent});
                console.log("docLabelCountsSorted")
                console.log(docLabelCountsSorted);
                console.log(numMatches)
                console.log('#'+divName+'-'+'categoryinfo')
                d3.select('#'+divName+'-'+'categoryinfo').selectAll("div").remove();
                if(showCategoryHeadings) {
                    d3.select('#'+divName+'-'+'categoryinfo').attr('display', 'inline');
                }
                function getCategoryStatsHTML(counts) {
                    return counts.matches + " document"
                        + (counts.matches == 1 ? "" : "s") + " out of " + counts.overall +': '
                        +counts['percent'].toFixed(2) + '%';
                }
                
                function getCategoryInlineHeadingHTML(counts) {
                    return '<a name="'+divName+'-category'
                        + counts.labelNum + '"></a>' 
                        + counts.label + ": <span class=topic_preview>"
                        + getCategoryStatsHTML(counts)
                        + "</span>";
                }


                docLabelCountsSorted.forEach(function(counts) {
                    var htmlToAdd = "<b>"+counts.label + "</b>: " +  getCategoryStatsHTML(counts);

                    if(counts.matches > 0) {
                        d3.select(divId)
                            .append("div")
                            .attr('class', 'text_header')
                            .html(getCategoryInlineHeadingHTML(counts));
                        allContexts
                            .filter(singleDoc => singleDoc.docLabel == counts.labelNum)
                            .forEach(function (singleDoc) {
                                addSnippets(singleDoc, divId);
                            });
                        if(includeAll) {
                            allNotMatches
                                .filter(singleDoc => singleDoc.docLabel == counts.labelNum)
                                .forEach(function (singleDoc) {
                                    addSnippets(singleDoc, divId, false);
                                });
                        }
                    }


                    if(showCategoryHeadings) {
                        d3.select('#'+divName+'-'+'categoryinfo')
                            .attr('display', 'inline')
                            .append('div')
                            .html(htmlToAdd)
                            .on("click", function() {window.location.hash = '#'+divName+'-'+'category' + counts.labelNum});
                    }

                })

            
            } else {
                var contextColumns = [
                    fullData.info.category_internal_name,
                    fullData.info.not_category_name
                ];
                if (showNeutral) {
                    if ('neutral_category_name' in fullData.info) {
                        contextColumns.push(fullData.info.neutral_category_name)
                    } else {
                        contextColumns.push("Neutral")
                    }
                    if (showExtra) {
                        if ('extra_category_name' in fullData.info) {
                            contextColumns.push(fullData.info.extra_category_name)
                        } else {
                            contextColumns.push("Extra")
                        }
                    }

                }
                contextColumns.map(
                    function (catName, catIndex) {
                        if (max_snippets != null) {
                            var contextsToDisplay = contexts[catIndex].slice(0, max_snippets);
                        }
                        console.log("CATCAT")
                        console.log(catName, catIndex)
                        //var divId = catName == catInternalName ? '#cat' : '#notcat';
                        var divId = null
                        if (catName == fullData.info.category_internal_name) {
                            divId = '#'+divName+'-'+'cat'
                        } else if (fullData.info.not_category_name == catName) {
                            divId = '#'+divName+'-'+'notcat'
                        } else if (fullData.info.neutral_category_name == catName) {
                            divId = '#'+divName+'-'+'neut';
                        } else if (fullData.info.extra_category_name == catName) {
                            divId = '#'+divName+'-'+'extra'
                        } else {
                            return;
                        }
                        console.log('divid');
                        console.log(divId)

                        var temp = d3.select(divId).selectAll("div").remove();
                        contexts[catIndex].forEach(function (context) {
                            addSnippets(context, divId);
                        });
                        if(includeAll) {
                            notmatches[catIndex].forEach(function (context) {
                                addSnippets(context, divId, false);
                            });
                        }
                    }
                );
            }

            var obscuredTerms = getObscuredTerms(data, termInfo.info);
            displayObscuredTerms(obscuredTerms, data, info.term, info, '#'+divName+'-'+'overlapped-terms-clicked');

            d3.select('#'+divName+'-'+'termstats')
                .selectAll("div")
                .remove();
            var termHtml = 'Term: <b>' + info.term + '</b>';
            if ('metalists' in fullData && info.term in fullData.metalists) {
                termHtml = 'Topic: <b>' + info.term + '</b>';
            }
            d3.select('#'+divName+'-'+'termstats')
                .append('div')
                .attr("class", "snippet_header")
                .html(termHtml);
            if ('metalists' in fullData && info.term in fullData.metalists) {
                d3.select('#'+divName+'-'+'termstats')
                    .attr("class", "topic_preview")
                    .append('div')
                    .html("<b>Topic preview</b>: "
                        + fullData.metalists[info.term]
                            .slice(0, topic_model_preview_size)
                            .reduce(function (x, y) {
                                return x + ', ' + y
                            }));
            }
            if ('metadescriptions' in fullData && info.term in fullData.metadescriptions) {
                d3.select('#'+divName+'-'+'termstats')
                    .attr("class", "topic_preview")
                    .append('div')
                    .html("<b>Description</b>: " + fullData.metadescriptions[info.term]);
            }
            var message = '';
            var cat_name = fullData.info.category_name;
            var ncat_name = fullData.info.not_category_name;


            var numCatDocs = fullData.docs.labels
                .map(function (x) {
                    return (x == fullData.docs.categories.indexOf(
                        fullData.info.category_internal_name)) + 0
                })
                .reduce(function (a, b) {
                    return a + b;
                })

            var notCategoryNumList = fullData.docs.categories.map(function (x, i) {
                if (fullData.info.not_category_internal_names.indexOf(x) > -1) {
                    return i;
                } else {
                    return -1;
                }
            }).filter(function (x) {
                return x > -1
            });


            var numNCatDocs = fullData.docs.labels
                .map(function (x) {
                    return notCategoryNumList.indexOf(x) > -1
                })
                .reduce(function (a, b) {
                    return a + b;
                });

            function getFrequencyDescription(name, count25k, count, ndocs) {
                var desc = name + ' frequency: <div class=text_subhead>' + count25k
                    + ' per 25,000 terms</div><div class=text_subhead>' + Math.round(ndocs)
                    + ' per 1,000 docs</div>';
                if (count == 0) {
                    desc += '<u>Not found in any ' + name + ' documents.</u>';
                } else {
                    desc += '<u>Some of the ' + count + ' mentions:</u>';
                }
                /*
                desc += '<br><b>Discriminative:</b> ';

                desc += contextWords
                    .slice(cat_name === name ? 0 : contextWords.length - 3,
                        cat_name === name ? 3 : contextWords.length)
                    .filter(function (x) {
                        //return Math.abs(x[5]) > 1.96;
                        return true;
                    })
                    .map(function (x) {return x.join(', ')}).join('<br>');
                */
                return desc;
            }

            if (!unifiedContexts) {
                console.log("NOT UNIFIED CONTEXTS")
                d3.select('#'+divName+'-'+'cathead')
                    .style('fill', color(1))
                    .html(
                        getFrequencyDescription(cat_name,
                            info.cat25k,
                            info.cat,
                            termInfo.contexts[0].length * 1000 / numCatDocs
                        )
                    );
                d3.select('#'+divName+'-'+'notcathead')
                    .style('fill', color(0))
                    .html(
                        getFrequencyDescription(ncat_name,
                            info.ncat25k,
                            info.ncat,
                            termInfo.contexts[1].length * 1000 / numNCatDocs)
                    );
                console.log("TermINfo")
                console.log(termInfo);
                console.log(info)
                if (showNeutral) {
                    console.log("NEUTRAL")

                    var numList = fullData.docs.categories.map(function (x, i) {
                        if (fullData.info.neutral_category_internal_names.indexOf(x) > -1) {
                            return i;
                        } else {
                            return -1;
                        }
                    }).filter(function (x) {
                        return x > -1
                    });

                    var numDocs = fullData.docs.labels
                        .map(function (x) {
                            return numList.indexOf(x) > -1
                        })
                        .reduce(function (a, b) {
                            return a + b;
                        });

                    d3.select("#" + divName + "-neuthead")
                        .style('fill', color(0))
                        .html(
                            getFrequencyDescription(fullData.info.neutral_category_name,
                                info.neut25k,
                                info.neut,
                                termInfo.contexts[2].length * 1000 / numDocs)
                        );

                    if (showExtra) {
                        console.log("EXTRA")
                        var numList = fullData.docs.categories.map(function (x, i) {
                            if (fullData.info.extra_category_internal_names.indexOf(x) > -1) {
                                return i;
                            } else {
                                return -1;
                            }
                        }).filter(function (x) {
                            return x > -1
                        });

                        var numDocs = fullData.docs.labels
                            .map(function (x) {
                                return numList.indexOf(x) > -1
                            })
                            .reduce(function (a, b) {
                                return a + b;
                            });

                        d3.select("#" + divName + "-extrahead")
                            .style('fill', color(0))
                            .html(
                                getFrequencyDescription(fullData.info.extra_category_name,
                                    info.extra25k,
                                    info.extra,
                                    termInfo.contexts[3].length * 1000 / numDocs)
                            );

                    }
                }
            } else {
                // extra unified context code goes here
                console.log("docLabelCountsSorted")
                console.log(docLabelCountsSorted)

                docLabelCountsSorted.forEach(function(counts) {
                    var htmlToAdd = "<b>"+counts.label + "</b>: " +  getCategoryStatsHTML(counts);
                    if(showCategoryHeadings) {
                        console.log("XXXX")
                        d3.select('#'+divName+'-'+'contexts')
                            .append('div')
                            .html("XX" + htmlToAdd)
                            .on("click", function() {window.location.hash = '#'+divName+'-'+'category' + counts.labelNum});
                    }
                })
            }
            if (jump) {
                if (window.location.hash == '#'+divName+'-'+'snippets') {
                    window.location.hash = '#'+divName+'-'+'snippetsalt';
                } else {
                    window.location.hash = '#'+divName+'-'+'snippets';
                }
            }
        }

        function searchInText(d, includeAll=true) {
            console.log("INCLUDE ALL")
            console.log(includeAll)
            function stripNonWordChars(term) {
                //d.term.replace(" ", "[^\\w]+")
            }

            function removeUnderScoreJoin(term) {
                /*
                '_ _asjdklf_jaksdlf_jaksdfl skld_Jjskld asdfjkl_sjkdlf'
                  ->
                "_ _asjdklf jaksdlf jaksdfl skld Jjskld asdfjkl_sjkdlf"
                 */
                return term.replace(/(\w+)(_)(\w+)/, "$1 $3")
                    .replace(/(\w+)(_)(\w+)/, "$1 $3")
                    .replace(/(\w+)(_)(\w+)/, "$1 $3");
            }

            function buildMatcher(term) {

                var boundary = '(?:\\W|^|$)';
                var wordSep = "[^\\w]+";
                if (asianMode) {
                    boundary = '( |$|^)';
                    wordSep = ' ';
                }
                if (isEmoji(term)) {
                    boundary = '';
                    wordSep = '';
                }
                var termToRegex = term;

                // https://stackoverflow.com/questions/3446170/escape-string-for-use-in-javascript-regex
                function escapeRegExp(string) {
                  return string.replace(/[#.*+?^${}()|[\]\\]/g, '\\$&'); // $& means the whole matched string
                }
                /*
                ['[', ']', '(', ')', '{', '}', '^', '$', '|', '?', '"',
                    '*', '+', '-', '=', '~', '`', '{'].forEach(function (a) {
                    termToRegex = termToRegex.replace(a, '\\\\' + a)
                });
                ['.', '#'].forEach(function(a) {termToRegex = termToRegex.replace(a, '\\' + a)})
                */
                termToRegex = escapeRegExp(termToRegex);
                var regexp = new RegExp(boundary + '('
                    + removeUnderScoreJoin(
                        termToRegex.replace(' ', wordSep, 'gim')
                    )
                    + ')' + boundary, 'gim');
                console.log(regexp)
                try {
                    regexp.exec('X');
                } catch (err) {
                    console.log("Can't search " + term);
                    console.log(err);
                    return null;
                }
                return regexp;
            }

            var matches = [[], [], [], []];
            var notmatches = [[], [], [], []];
            var pattern = buildMatcher(d.term);
            var categoryNum = fullData.docs.categories.indexOf(fullData.info.category_internal_name);
            var notCategoryNumList = fullData.docs.categories.map(function (x, i) {
                if (fullData.info.not_category_internal_names.indexOf(x) > -1) {
                    return i;
                } else {
                    return -1;
                }
            }).filter(function (x) {
                return x > -1
            });
            var neutralCategoryNumList = fullData.docs.categories.map(function (x, i) {
                if (fullData.info.neutral_category_internal_names.indexOf(x) > -1) {
                    return i;
                } else {
                    return -1;
                }
            }).filter(function (x) {
                return x > -1
            });
            var extraCategoryNumList = fullData.docs.categories.map(function (x, i) {
                if (fullData.info.extra_category_internal_names.indexOf(x) > -1) {
                    return i;
                } else {
                    return -1;
                }
            }).filter(function (x) {
                return x > -1
            });
            console.log('extraCategoryNumList')
            console.log(extraCategoryNumList);
            console.log("categoryNum");
            console.log(categoryNum);
            console.log("categoryNum");
            if (pattern !== null) {
                for (var i in fullData.docs.texts) {
                    //var numericLabel = 1 * (fullData.docs.categories[fullData.docs.labels[i]] != fullData.info.category_internal_name);

                    var docLabel = fullData.docs.labels[i];
                    var numericLabel = -1;
                    if (docLabel == categoryNum) {
                        numericLabel = 0;
                    } else if (notCategoryNumList.indexOf(docLabel) > -1) {
                        numericLabel = 1;
                    } else if (neutralCategoryNumList.indexOf(docLabel) > -1) {
                        numericLabel = 2;
                    } else if (extraCategoryNumList.indexOf(docLabel) > -1) {
                        numericLabel = 3;
                    }
                    if (numericLabel == -1) {
                        continue;
                    }

                    var text = removeUnderScoreJoin(fullData.docs.texts[i]);
                    //var pattern = new RegExp("\\b(" + stripNonWordChars(d.term) + ")\\b", "gim");
                    var match;
                    var sentenceOffsets = null;
                    var lastSentenceStart = null;
                    var matchFound = false;
                    var curMatch = {'id': i, 'snippets': [], 'notsnippets': [], 'docLabel': docLabel};
                    if (fullData.docs.meta) {
                        curMatch['meta'] = fullData.docs.meta[i];
                    }
                    
                    while ((match = pattern.exec(text)) != null) {
                        if (sentenceOffsets == null) {
                            sentenceOffsets = getSentenceBoundaries(text);
                        }
                        var foundSnippet = getMatchingSnippet(text, sentenceOffsets,
                            match.index, pattern.lastIndex);
                        if (foundSnippet.sentenceStart == lastSentenceStart) continue; // ensure we don't duplicate sentences
                        lastSentenceStart = foundSnippet.sentenceStart;
                        curMatch.snippets.push(foundSnippet.snippet);
                        matchFound = true;
                    }
                    if (matchFound) {
                        if (useFullDoc) {
                            curMatch.snippets = [
                                text
                                    .replace(/\n$/g, '\n\n')
                                    .replace(
                                        //new RegExp("\\b(" + d.term.replace(" ", "[^\\w]+") + ")\\b",
                                        //    'gim'),
                                        pattern,
                                        '<b>$&</b>')
                            ];
                        }
                        matches[numericLabel].push(curMatch);
                    } else {
                        if (includeAll) {
                            curMatch.snippets = [
                                text.replace(/\n$/g, '\n\n')
                            ];
                            notmatches[numericLabel].push(curMatch);
                        }
                        
                    }
                }
            }
            var toRet = {'contexts': matches, 
                         'notmatches': notmatches, 
                         'info': d, 
                         'docLabel': docLabel};
            return toRet;
        }

        function getDefaultTooltipContent(d) {
            var message = d.term + "<br/>" + d.cat25k + ":" + d.ncat25k + " per 25k words";
            message += '<br/>score: ' + d.os.toFixed(5);
            return message;
        }

        function getDefaultTooltipContentWithoutScore(d) {
            var message = d.term + "<br/>" + d.cat25k + ":" + d.ncat25k + " per 25k words";
            return message;
        }

        function getObscuredTerms(data, d) {
            //data = fullData['data']
            var matches = (data.filter(function (term) {
                    return term.x === d.x && term.y === d.y && (term.display === undefined || term.display === true);
                }).map(function (term) {
                    return term.term
                }).sort()
            );
            return matches;
        }

        function showTooltip(data, d, pageX, pageY, showObscured=true) {
            deselectLastCircle();

            var obscuredTerms = getObscuredTerms(data, d);
            var message = '';
            console.log("!!!!! " + obscuredTerms.length)
            console.log(showObscured)
            if (obscuredTerms.length > 1 && showObscured)
                displayObscuredTerms(obscuredTerms, data, d.term, d);
            if (getTooltipContent !== null) {
                message += getTooltipContent(d);
            } else {
                if (sortByDist) {
                    message += getDefaultTooltipContentWithoutScore(d);
                } else {
                    message += getDefaultTooltipContent(d);
                }
            }
            pageX -= (svg.node().getBoundingClientRect().left) - origSVGLeft;
            pageY -= (svg.node().getBoundingClientRect().top) - origSVGTop;
            tooltip.transition()
                .duration(0)
                .style("opacity", 1)
                .style("z-index", 10000000);
            tooltip.html(message)
                .style("left", (pageX - 40) + "px")
                .style("top", (pageY - 85 > 0 ? pageY - 85 : 0) + "px");
            tooltip.on('click', function () {
                tooltip.transition()
                    .style('opacity', 0)
            }).on('mouseout', function () {
                tooltip.transition().style('opacity', 0)
            });
        }

        handleSearch = function (event) {
            deselectLastCircle();
            var searchTerm = document
                .getElementById(this.divName + "-searchTerm")
                .value
                .toLowerCase()
                .replace("'", " '")
                .trim();
            if(this.termDict[searchTerm] !== undefined) {
                showToolTipForTerm(this.data, this.svg, searchTerm, this.termDict[searchTerm], true);
            }
            if (this.termDict[searchTerm] != null) {
                var runDisplayTermContexts = true;
                if(alternativeTermFunc != null) {
                    runDisplayTermContexts = this.alternativeTermFunc(this.termDict[searchTerm]);
                }
                if(runDisplayTermContexts) {
                    displayTermContexts(this.data, 
                                        this.gatherTermContexts(this.termDict[searchTerm], this.includeAllContexts), false,
                                        this.includeAllContexts);
                }
            }
            return false;
        };

        function showToolTipForTerm(data, mysvg, searchTerm, searchTermInfo, showObscured=true) {
            //var searchTermInfo = termDict[searchTerm];
            console.log("showing tool tip")
            console.log(searchTerm)
            console.log(searchTermInfo)
            if (searchTermInfo === undefined) {
                console.log("can't show")
                d3.select("#" + divName + "-alertMessage")
                    .text(searchTerm + " didn't make it into the visualization.");
            } else {
                d3.select("#" + divName + "-alertMessage").text("");
                var circle = mysvg; 
                console.log("mysvg"); console.log(mysvg)
                if(circle.tagName !== "circle") { // need to clean this thing up
                    circle = mysvg._groups[0][searchTermInfo.ci];
                    if(circle === undefined || circle.tagName != 'circle') {
                        console.log("circle0")
                        if(mysvg._groups[0].children !== undefined) {
                            circle = mysvg._groups[0].children[searchTermInfo.ci];
                        }
                    }
                    if(circle === undefined || circle.tagName != 'circle') {
                        console.log("circle1"); 
                        if(mysvg._groups[0][0].children !== undefined) {
                            circle = Array.prototype.filter.call(
                                mysvg._groups[0][0].children, 
                                x=> (x.tagName == "circle" && x.__data__['term'] == searchTermInfo.term)
                            )[0];
                        }
                        console.log(circle)
                    }
                    if((circle === undefined || circle.tagName != 'circle') && mysvg._groups[0][0].children !== undefined) {
                        console.log("circle2"); 
                        console.log(mysvg._groups[0][0])
                        console.log(mysvg._groups[0][0].children)
                        console.log(searchTermInfo.ci);
                        circle = mysvg._groups[0][0].children[searchTermInfo.ci];
                        console.log(circle)
                    }
                }
                if(circle) {
                    var mySVGMatrix = circle.getScreenCTM().translate(circle.cx.baseVal.value, circle.cy.baseVal.value);
                    var pageX = mySVGMatrix.e;
                    var pageY = mySVGMatrix.f;
                    circle.style["stroke"] = "black";
                    //var circlePos = circle.position();
                    //var el = circle.node()
                    //showTooltip(searchTermInfo, pageX, pageY, circle.cx.baseVal.value, circle.cx.baseVal.value);
                    showTooltip(
                        data,
                        searchTermInfo,
                        pageX,
                        pageY,
                        showObscured
                    );

                    lastCircleSelected = circle;
                }

            }
        };


        function makeWordInteractive(data, svg, domObj, term, termInfo, showObscured=true) {
            return domObj
                .on("mouseover", function (d) {
                    console.log("mouseover" )
                    console.log(term)
                    console.log(termInfo)
                    showToolTipForTerm(data, svg, term, termInfo, showObscured);
                    d3.select(this).style("stroke", "black");
                })
                .on("mouseout", function (d) {
                    tooltip.transition()
                        .duration(0)
                        .style("opacity", 0);
                    d3.select(this).style("stroke", null);
                    if (showObscured) {
                        d3.select('#'+divName+'-'+'overlapped-terms')
                            .selectAll('div')
                            .remove();
                    }
                })
                .on("click", function (d) {
                    var runDisplayTermContexts = true;
                    if(alternativeTermFunc != null) {
                        runDisplayTermContexts = alternativeTermFunc(termInfo);
                    }
                    if(runDisplayTermContexts) {
                        displayTermContexts(data, gatherTermContexts(termInfo, includeAllContexts), true, includeAllContexts);
                    }
                });
        }

        function processData(fullData) {
            
            modelInfo = fullData['info'];
            /*
             categoryTermList.data(modelInfo['category_terms'])
             .enter()
             .append("li")
             .text(function(d) {return d;});
             */
            var data = fullData['data'];
            termDict = Object();
            data.forEach(function (x, i) {
                termDict[x.term] = x;
                //!!!
                //termDict[x.term].i = i;
            });

            var padding = 0;
            if (showAxes) {
                padding = 0.1;
            }

            // Scale the range of the data.  Add some space on either end.
            x.domain([-1 * padding, d3.max(data, function (d) {
                return d.x;
            }) + padding]);
            y.domain([-1 * padding, d3.max(data, function (d) {
                return d.y;
            }) + padding]);

            /*
             data.sort(function (a, b) {
             return Math.abs(b.os) - Math.abs(a.os)
             });
             */


            //var rangeTree = null; // keep boxes of all points and labels here
            var rectHolder = new RectangleHolder();
            // Add the scatterplot
            data.forEach(function(d,i) {d.ci = i});
            //console.log('XXXXX'); console.log(data)
            var mysvg = svg
                .selectAll("dot")
                .data(data.filter(d=>d.display === undefined || d.display === true))
                //.filter(function (d) {return d.display === undefined || d.display === true})
                .enter()
                .append("circle")
                .attr("r", function (d) {
                    if (pValueColors && d.p) {
                        return (d.p >= 1 - minPVal || d.p <= minPVal) ? 2 : 1.75;
                    }
                    return 2;
                })
                .attr("cx", function (d) {
                    return x(d.x);
                })
                .attr("cy", function (d) {
                    return y(d.y);
                })
                .style("fill", function (d) {
                    //.attr("fill", function (d) {
                    if (colorFunc) {
                        return colorFunc(d);
                    } else if (greyZeroScores && d.os == 0) {
                        return d3.rgb(230, 230, 230);
                    } else if (pValueColors && d.p) {
                        if (d.p >= 1 - minPVal) {
                            return wordVecMaxPValue ? d3.interpolateYlGnBu(d.s) : color(d.s);
                        } else if (d.p <= minPVal) {
                            return wordVecMaxPValue ? d3.interpolateYlGnBu(d.s) : color(d.s);
                        } else {
                            return interpolateLightGreys(d.s);
                        }
                    } else {
                        if(d.term == "psychological") {
                            console.log("COLS " + d.s + " " + color(d.s) + " " + d.term)
                            console.log(d)
                            console.log(color)
                        }
                        return color(d.s);
                    }
                })
                .on("mouseover", function (d) {
                    /*var mySVGMatrix = circle.getScreenCTM()n
                        .translate(circle.cx.baseVal.value, circle.cy.baseVal.value);
                    var pageX = mySVGMatrix.e;
                    var pageY = mySVGMatrix.f;*/

                    /*showTooltip(
                        d,
                        d3.event.pageX,
                        d3.event.pageY
                    );*/
                    console.log("point MOUSOEVER")
                    console.log(d)
                    showToolTipForTerm(data, this, d.term, d, true);
                    d3.select(this).style("stroke", "black");
                })
                .on("click", function (d) {
                    var runDisplayTermContexts = true;
                    if(alternativeTermFunc != null) {
                        runDisplayTermContexts = alternativeTermFunc(d);
                    }
                    if(runDisplayTermContexts) {
                        displayTermContexts(data, gatherTermContexts(d), true, includeAllContexts);
                    }
                })
                .on("mouseout", function (d) {
                    tooltip.transition()
                        .duration(0)
                        .style("opacity", 0);
                    d3.select(this).style("stroke", null);
                    d3.select('#'+divName+'-'+'overlapped-terms')
                        .selectAll('div')
                        .remove();
                })
            
            
            coords = Object();

            var pointStore = [];
            var pointRects = [];

            function censorPoints(datum, getX, getY) {
                var term = datum.term;
                var curLabel = svg.append("text")
                    .attr("x", x(getX(datum)))
                    .attr("y", y(getY(datum)) + 3)
                    .attr("text-anchor", "middle")
                    .text("x");
                var bbox = curLabel.node().getBBox();
                var borderToRemove = .5;
                var x1 = bbox.x + borderToRemove,
                    y1 = bbox.y + borderToRemove,
                    x2 = bbox.x + bbox.width - borderToRemove,
                    y2 = bbox.y + bbox.height - borderToRemove;
                //rangeTree = insertRangeTree(rangeTree, x1, y1, x2, y2, '~~' + term);
                var pointRect = new Rectangle(x1, y1, x2, y2);
                pointRects.push(pointRect);
                rectHolder.add(pointRect);
                pointStore.push([x1, y1]);
                pointStore.push([x2, y1]);
                pointStore.push([x1, y2]);
                pointStore.push([x2, y2]);
                curLabel.remove();
            }
            
            function censorCircle(xCoord, yCoord) {
                var curLabel = svg.append("text")
                    .attr("x", x(xCoord))
                    .attr("y", y(yCoord) + 3)
                    .attr("text-anchor", "middle")
                    .text("x");
                var bbox = curLabel.node().getBBox();
                var borderToRemove = .5;
                var x1 = bbox.x + borderToRemove,
                    y1 = bbox.y + borderToRemove,
                    x2 = bbox.x + bbox.width - borderToRemove,
                    y2 = bbox.y + bbox.height - borderToRemove;
                var pointRect = new Rectangle(x1, y1, x2, y2);
                pointRects.push(pointRect);
                rectHolder.add(pointRect);
                pointStore.push([x1, y1]);
                pointStore.push([x2, y1]);
                pointStore.push([x1, y2]);
                pointStore.push([x2, y2]);
                curLabel.remove();
            }

            function labelPointsIfPossible(datum, myX, myY) {
                var term = datum.term;
                if(term == "the") 
                    console.log("TERM " + term + " " + myX + " " + myY)
                //console.log('xxx'); console.log(term); console.log(term.display !== undefined && term.display === false)
                //if(term.display !== undefined && term.display === false) {
                //    return false;
                //}
                var configs = [
                    {'anchor': 'end', 'xoff': -5, 'yoff': -3, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'end', 'xoff': -5, 'yoff': 10, 'alignment-baseline': 'ideographic'},
                    
                    {'anchor': 'end', 'xoff': 10, 'yoff': 15, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'end', 'xoff': -10, 'yoff': -15, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'end', 'xoff': 10, 'yoff': -15, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'end', 'xoff': -10, 'yoff': 15, 'alignment-baseline': 'ideographic'},
                    
                    {'anchor': 'start', 'xoff': 3, 'yoff': 10, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'start', 'xoff': 3, 'yoff': -3, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'start', 'xoff': 5, 'yoff': 10, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'start', 'xoff': 5, 'yoff': -3, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'start', 'xoff': 10, 'yoff': 15, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'start', 'xoff': -10, 'yoff': -15, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'start', 'xoff': 10, 'yoff': -15, 'alignment-baseline': 'ideographic'},
                    {'anchor': 'start', 'xoff': -10, 'yoff': 15, 'alignment-baseline': 'ideographic'},
                ];
                if (centerLabelsOverPoints) {
                    configs = [{'anchor': 'middle', 'xoff': 0, 'yoff': 0, 'alignment-baseline': 'middle'}];
                }
                var matchedElement = null;
                for (var configI in configs) {
                    var config = configs[configI];
                    var curLabel = svg.append("text")
                    //.attr("x", x(data[i].x) + config['xoff'])
                    //.attr("y", y(data[i].y) + config['yoff'])
                        .attr("x", x(myX) + config['xoff'])
                        .attr("y", y(myY) + config['yoff'])
                        .attr('class', 'label')
                        .attr('class', 'pointlabel')
                        .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                        .attr('font-size', '10px')
                        .attr("text-anchor", config['anchor'])
                        .attr("alignment-baseline", config['alignment'])
                        .text(term);
                    var bbox = curLabel.node().getBBox();
                    var borderToRemove = .25;
                    if (doCensorPoints) {
                        var borderToRemove = .5;
                    }

                    var x1 = bbox.x + borderToRemove,
                        y1 = bbox.y + borderToRemove,
                        x2 = bbox.x + bbox.width - borderToRemove,
                        y2 = bbox.y + bbox.height - borderToRemove;
                    //matchedElement = searchRangeTree(rangeTree, x1, y1, x2, y2);
                    var matchedElement = false;
                    rectHolder.findMatchingRectangles(x1, y1, x2, y2, function (elem) {
                        matchedElement = true;
                        return false;
                    });
                    if (matchedElement) {
                        curLabel.remove();
                    } else {
                        curLabel = makeWordInteractive(data, svg, curLabel, term, datum);
                        break;
                    }
                }

                if (!matchedElement) {
                    coords[term] = [x1, y1, x2, y2];
                    //rangeTree = insertRangeTree(rangeTree, x1, y1, x2, y2, term);
                    var labelRect = new Rectangle(x1, y1, x2, y2)
                    rectHolder.add(labelRect);
                    pointStore.push([x1, y1]);
                    pointStore.push([x2, y1]);
                    pointStore.push([x1, y2]);
                    pointStore.push([x2, y2]);
                    return {label: curLabel, rect: labelRect};
                } else {
                    //curLabel.remove();
                    return false;
                }

            }

            var radius = 2;

            function euclideanDistanceSort(a, b) {
                var aCatDist = a.x * a.x + (1 - a.y) * (1 - a.y);
                var aNotCatDist = a.y * a.y + (1 - a.x) * (1 - a.x);
                var bCatDist = b.x * b.x + (1 - b.y) * (1 - b.y);
                var bNotCatDist = b.y * b.y + (1 - b.x) * (1 - b.x);
                return (Math.min(aCatDist, aNotCatDist) > Math.min(bCatDist, bNotCatDist)) * 2 - 1;
            }

            function euclideanDistanceSortForCategory(a, b) {
                var aCatDist = a.x * a.x + (1 - a.y) * (1 - a.y);
                var bCatDist = b.x * b.x + (1 - b.y) * (1 - b.y);
                return (aCatDist > bCatDist) * 2 - 1;
            }

            function euclideanDistanceSortForNotCategory(a, b) {
                var aNotCatDist = a.y * a.y + (1 - a.x) * (1 - a.x);
                var bNotCatDist = b.y * b.y + (1 - b.x) * (1 - b.x);
                return (aNotCatDist > bNotCatDist) * 2 - 1;
            }

            function scoreSort(a, b) {
                return a.s - b.s;
            }

            function scoreSortReverse(a, b) {
                return b.s - a.s;
            }

            function backgroundScoreSort(a, b) {
                if (b.bg === a.bg)
                    return (b.cat + b.ncat) - (a.cat + a.ncat);
                return b.bg - a.bg;
            }

            function arePointsPredictiveOfDifferentCategories(a, b) {
                var aCatDist = a.x * a.x + (1 - a.y) * (1 - a.y);
                var bCatDist = b.x * b.x + (1 - b.y) * (1 - b.y);
                var aNotCatDist = a.y * a.y + (1 - a.x) * (1 - a.x);
                var bNotCatDist = b.y * b.y + (1 - b.x) * (1 - b.x);
                var aGood = aCatDist < aNotCatDist;
                var bGood = bCatDist < bNotCatDist;
                return {aGood: aGood, bGood: bGood};
            }

            function scoreSortForCategory(a, b) {
                var __ret = arePointsPredictiveOfDifferentCategories(a, b);
                if (sortByDist) {
                    var aGood = __ret.aGood;
                    var bGood = __ret.bGood;
                    if (aGood && !bGood) return -1;
                    if (!aGood && bGood) return 1;
                }
                return b.s - a.s;
            }

            function scoreSortForNotCategory(a, b) {
                var __ret = arePointsPredictiveOfDifferentCategories(a, b);
                if (sortByDist) {
                    var aGood = __ret.aGood;
                    var bGood = __ret.bGood;
                    if (aGood && !bGood) return 1;
                    if (!aGood && bGood) return -1;
                }
                if (reverseSortScoresForNotCategory)
                    return a.s - b.s;
                else
                    return b.s - a.s;
            }

            var sortedData = data.map(x=>x).sort(sortByDist ? euclideanDistanceSort : scoreSort);
            if (doCensorPoints) {
                for (var i in data) {
                    var d = sortedData[i];
                    censorPoints(
                        d,
                        function (d) {
                            return d.x
                        },
                        function (d) {
                            return d.y
                        }
                    );
                }
            }


            function registerFigureBBox(curLabel) {
                var bbox = curLabel.node().getBBox();
                var borderToRemove = 1.5;
                var x1 = bbox.x + borderToRemove,
                    y1 = bbox.y + borderToRemove,
                    x2 = bbox.x + bbox.width - borderToRemove,
                    y2 = bbox.y + bbox.height - borderToRemove;
                rectHolder.add(new Rectangle(x1, y1, x2, y2));
                //return insertRangeTree(rangeTree, x1, y1, x2, y2, '~~_other_');
            }
            function drawXLabel(svg, labelText) {
                    return svg.append("text")
                    .attr("class", "x label")
                    .attr("text-anchor", "end")
                    .attr("x", width)
                    .attr("y", height - 6)
                    .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                    .attr('font-size', '10px')
                    .text(labelText);
            }
            function drawYLabel(svg, labelText) {
                    return svg.append("text")
                        .attr("class", "y label")
                        .attr("text-anchor", "end")
                        .attr("y", 6)
                        .attr("dy", ".75em")
                        .attr("transform", "rotate(-90)")
                        .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                        .attr('font-size', '10px')
                        .text(labelText);
                        registerFigureBBox(yLabel);
                }

            d3.selection.prototype.moveToBack = function () {
                return this.each(function () {
                    var firstChild = this.parentNode.firstChild;
                    if (firstChild) {
                        this.parentNode.insertBefore(this, firstChild);
                    }
                });
            };

            if (verticalLines) {
                for (i in verticalLines) {
                    svg.append("g")
                        .attr("transform", "translate(" + x(verticalLines) + ", 1)")
                        .append("line")
                        .attr("y2", height)
                        .style("stroke", "#dddddd")
                        .style("stroke-width", "1px")
                        .moveToBack();
                }
            }

            if (showAxes) {

                var myXAxis = svg.append("g")
                    .attr("class", "x axis")
                    .attr("transform", "translate(0," + height + ")")
                    .call(xAxis);

                //rangeTree = registerFigureBBox(myXAxis);
                

                var xLabel = drawXLabel(svg, getLabelText('x'));

                //console.log('xLabel');
                //console.log(xLabel);

                //rangeTree = registerFigureBBox(xLabel);
                // Add the Y Axis

                if (!yAxisValues) {
                    var myYAxis = svg.append("g")
                        .attr("class", "y axis")
                        .call(yAxis)
                        .selectAll("text")
                        .style("text-anchor", "end")
                        .attr("dx", "30px")
                        .attr("dy", "-13px")
                        .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                        .attr('font-size', '10px')
                        .attr("transform", "rotate(-90)");
                } else {
                    var myYAxis = svg.append("g")
                        .attr("class", "y axis")
                        .call(yAxis)
                        .selectAll("text")
                        .style("text-anchor", "end")
                        .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                        .attr('font-size', '10px');
                }
                registerFigureBBox(myYAxis);

                function getLabelText(axis) {
                    if (axis == 'y') {
                        if (yLabelText == null)
                            return modelInfo['category_name'] + " Frequency";
                        else
                            return yLabelText;
                    } else {
                        if (xLabelText == null)
                            return modelInfo['not_category_name'] + " Frequency";
                        else
                            return xLabelText;
                    }
                }
                var yLabel = drawYLabel(svg, getLabelText('y'))
                
            
            } else {
                horizontal_line_y_position_translated = 0.5;
                if(horizontal_line_y_position !== null) {
                   var loOy = null, hiOy = null, loY = null, hiY = null;
                   for(i in fullData.data) {
                        var curOy = fullData.data[i].oy;
                        if(curOy < horizontal_line_y_position && (curOy > loOy || loOy === null)) {
                              loOy = curOy;
                              loY = fullData.data[i].y
                        }
                        if(curOy > horizontal_line_y_position && (curOy < hiOy || hiOy === null)) {
                              hiOy = curOy;
                              hiY = fullData.data[i].y
                        }
                   }
                   horizontal_line_y_position_translated = loY + (hiY - loY)/2.
                   if(loY === null) {
                        horizontal_line_y_position_translated = 0;
                   }
                }
                if(vertical_line_x_position === null) {
                    vertical_line_x_position_translated = 0.5;
                } else {
                    if(vertical_line_x_position !== null) {
                       var loOx = null, hiOx = null, loX = null, hiX = null;
                       for(i in fullData.data) {
                            var curOx = fullData.data[i].ox;
                            if(curOx < vertical_line_x_position && (curOx > loOx || loOx === null)) {
                                  loOx = curOx;
                                  loX = fullData.data[i].x;
                            }
                            if(curOx > vertical_line_x_position && (curOx < hiOx || hiOx === null)) {
                                  hiOx = curOx;
                                  hiX = fullData.data[i].x
                            }
                       }
                       vertical_line_x_position_translated = loX + (hiX - loX)/2.
                       if(loX === null) {
                            vertical_line_x_position_translated = 0;
                       }
                    }
                }
                if(showCrossAxes) {
                    var x_line = svg.append("g")
                        .attr("transform", "translate(0, " + y(horizontal_line_y_position_translated) + ")")
                        .append("line")
                        .attr("x2", width)
                        .style("stroke", "#cccccc")
                        .style("stroke-width", "1px")
                        .moveToBack();
                    var y_line = svg.append("g")
                        .attr("transform", "translate(" + x(vertical_line_x_position_translated) + ", 0)")
                        .append("line")
                        .attr("y2", height)
                        .style("stroke", "#cccccc")
                        .style("stroke-width", "1px")
                        .moveToBack();
                }
            }

            function showWordList(word, termDataList) {
                var maxWidth = word.node().getBBox().width;
                var wordObjList = [];
                for (var i in termDataList) {
                    var curTerm = termDataList[i].term;
                    word = (function (word, curTerm) {
                        var curWordPrinted = svg.append("text")
                                .attr("text-anchor", "start")
                                .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                                .attr('font-size', '12px')
                                .attr("x", word.node().getBBox().x)
                                .attr("y", word.node().getBBox().y
                                    + 2 * word.node().getBBox().height)
                                .text(curTerm);
                        wordObjList.push(curWordPrinted)
                        return makeWordInteractive(
                            termDataList, //data,
                            svg, 
                            curWordPrinted,
                            curTerm,
                            termDataList[i]);
                    })(word, curTerm);
                    if (word.node().getBBox().width > maxWidth)
                        maxWidth = word.node().getBBox().width;
                    registerFigureBBox(word);
                }
                return {
                    'word': word,
                    'maxWidth': maxWidth,
                    'wordObjList':wordObjList
                };
            }

            function pickEuclideanDistanceSortAlgo(category) {
                if (category == true) return euclideanDistanceSortForCategory;
                return euclideanDistanceSortForNotCategory;
            }

            function pickScoreSortAlgo(category) {
                console.log("PICK SCORE ALGO")
                console.log(category)
                if (category == true) {
                    return scoreSortForCategory;
                } else {
                    return scoreSortForNotCategory;
                }
            }

            function pickTermSortingAlgorithm(category) {
                if (sortByDist) return pickEuclideanDistanceSortAlgo(category);
                return pickScoreSortAlgo(category);
            }

            function showAssociatedWordList(data, word, header, isAssociatedToCategory,  length=14) {
                var sortedData = null;
                var sortingAlgo = pickTermSortingAlgorithm(isAssociatedToCategory);
                sortedData = data.filter(term => (term.display === undefined || term.display === true)).sort(sortingAlgo);
                if (wordVecMaxPValue) {
                    function signifTest(x) {
                        if (isAssociatedToCategory)
                            return x.p >= 1 - minPVal;
                        return x.p <= minPVal;
                    }

                    sortedData = sortedData.filter(signifTest)
                }
                return showWordList(word, sortedData.slice(0, length));

            }
            var characteristicXOffset = width;
            function showCatHeader(startingOffset, catName, registerFigureBBox) {
                var catHeader =  svg.append("text")
                .attr("text-anchor", "start")
                .attr("x", startingOffset //width
                     )
                .attr("dy", "6px")
                .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                .attr('font-size', '12px')
                .attr('font-weight', 'bolder')
                .attr('font-decoration', 'underline')
                .text(catName
                      //"Top " + fullData['info']['category_name']
                     );
                registerFigureBBox(catHeader);
                return catHeader;
            }

            function showNotCatHeader(startingOffset, word, notCatName) {
                console.log("showNotCatHeader")
                console.log(word)
                console.log(word.node().getBBox().y - word.node().getBBox().height)
                console.log(word.node().getBBox().y + word.node().getBBox().height)
                return svg.append("text")
                .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                .attr('font-size', '12px')
                .attr('font-weight', 'bolder')
                .attr('font-decoration', 'underline')
                .attr("text-anchor", "start")
                .attr("x", startingOffset)
                .attr("y", word.node().getBBox().y + 3 * word.node().getBBox().height)
                .text(notCatName);
            }

            function showTopTermsPane(data,
                                       registerFigureBBox, 
                                       showAssociatedWordList,
                                       catName,
                                       notCatName,
                                       startingOffset) {
                data = data.filter(term => (term.display === undefined || term.display === true));
                //var catHeader = showCatHeader(startingOffset, catName, registerFigureBBox);
                var catHeader = svg.append("text")
                .attr("text-anchor", "start")
                .attr("x", startingOffset)
                .attr("dy", "6px")
                .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                .attr('font-size', '12px')
                .attr('font-weight', 'bolder')
                .attr('font-decoration', 'underline')
                .text(catName
                      //"Top " + fullData['info']['category_name']
                     );
                registerFigureBBox(catHeader);
                var word = catHeader;
                var wordListData = showAssociatedWordList(data, word, catHeader, true);
                word = wordListData.word;
                var maxWidth = wordListData.maxWidth;

                var notCatHeader = showNotCatHeader(startingOffset, word, notCatName);
                word = notCatHeader;
                characteristicXOffset = catHeader.node().getBBox().x + maxWidth + 10;

                var notWordListData = showAssociatedWordList(data, word, notCatHeader, false);
                word = wordListData.word;
                if (wordListData.maxWidth > maxWidth) {
                    maxWidth = wordListData.maxWidth;
                }
                return {wordListData, notWordListData,
                        word, maxWidth, characteristicXOffset, startingOffset,
                        catHeader, notCatHeader, registerFigureBBox};
            }

            var payload = Object();
            if (showTopTerms) {
                payload.topTermsPane = showTopTermsPane(
                    data,
                    registerFigureBBox, 
                    showAssociatedWordList,
                    "Top " + fullData['info']['category_name'],
                    "Top " + fullData['info']['not_category_name'],
                    width
                );
                payload.showTopTermsPane = showTopTermsPane;
                payload.showAssociatedWordList = showAssociatedWordList;
                payload.showWordList = showWordList;
                /*var wordListData = topTermsPane.wordListData;
                var word = topTermsPane.word;
                var maxWidth = topTermsPane.maxWidth;
                var catHeader = topTermsPane.catHeader;
                var notCatHeader = topTermsPane.notCatHeader;
                var startingOffset = topTermsPane.startingOffset;*/
                characteristicXOffset = payload.topTermsPane.characteristicXOffset;
            }


            if (!nonTextFeaturesMode && !asianMode && showCharacteristic) {
                var sortMethod = backgroundScoreSort;
                var title = 'Characteristic';
                if (wordVecMaxPValue) {
                    title = 'Most similar';
                    sortMethod = scoreSortReverse;
                } else if (data.reduce(function (a, b) {
                        return a + b.bg
                    }, 0) === 0) {
                    title = 'Most frequent';
                }
                word = svg.append("text")
                    .attr('font-family', 'Helvetica, Arial, Sans-Serif')
                    .attr("text-anchor", "start")
                    .attr('font-size', '12px')
                    .attr('font-weight', 'bolder')
                    .attr('font-decoration', 'underline')
                    .attr("x", characteristicXOffset)
                    .attr("dy", "6px")
                    .text(title);

                var wordListData = showWordList(word, data.filter(term => (term.display === undefined || term.display === true)).sort(sortMethod).slice(0, 30));

                word = wordListData.word;
                maxWidth = wordListData.maxWidth;
                console.log(maxWidth);
                console.log(word.node().getBBox().x + maxWidth);

                svg.attr('width', word.node().getBBox().x + 3 * maxWidth + 10);
            }

            function performPartialLabeling(data, existingLabels, getX, getY) {
                for (i in existingLabels) {
                    rectHolder.remove(existingLabels[i].rect);
                    existingLabels[i].label.remove();
                }
                console.log('labeling 1')
                

                var labeledPoints = [];
                //var filteredData = data.filter(d=>d.display === undefined || d.display === true);
                //for (var i = 0; i < filteredData.length; i++) {
                data.forEach(function(datum, i) {
                    //console.log(datum.i, datum.ci, i)
                    //var label = labelPointsIfPossible(i, getX(filteredData[i]), getY(filteredData[i]));
                    if(datum.display === undefined || datum.display === true) {
                        if(datum.term == "the" || i == 1) {
                            console.log("trying to label datum # " + i + ": " + datum.term)
                            console.log(datum)
                            console.log([getX(datum), getY(datum)])
                        }
                        var label = labelPointsIfPossible(datum, getX(datum), getY(datum));
                        if (label !== false) {
                            //console.log("labeled")
                            labeledPoints.push(label)
                        }
                    }
                    //if (labelPointsIfPossible(i), true) numPointsLabeled++;
                })
                return labeledPoints;
            }

            //var labeledPoints = performPartialLabeling();
            var labeledPoints = [];
            labeledPoints = performPartialLabeling(data,
                                                   labeledPoints,
                                                   function (d) {return d.x},
                                                   function (d) {return d.y});



            /*
            // pointset has to be sorted by X
            function convex(pointset) {
                function _cross(o, a, b) {
                    return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0]);
                }

                function _upperTangent(pointset) {
                    var lower = [];
                    for (var l = 0; l < pointset.length; l++) {
                        while (lower.length >= 2 && (_cross(lower[lower.length - 2], lower[lower.length - 1], pointset[l]) <= 0)) {
                            lower.pop();
                        }
                        lower.push(pointset[l]);
                    }
                    lower.pop();
                    return lower;
                }

                function _lowerTangent(pointset) {
                    var reversed = pointset.reverse(),
                        upper = [];
                    for (var u = 0; u < reversed.length; u++) {
                        while (upper.length >= 2 && (_cross(upper[upper.length - 2], upper[upper.length - 1], reversed[u]) <= 0)) {
                            upper.pop();
                        }
                        upper.push(reversed[u]);
                    }
                    upper.pop();
                    return upper;
                }

                var convex,
                    upper = _upperTangent(pointset),
                    lower = _lowerTangent(pointset);
                convex = lower.concat(upper);
                convex.push(pointset[0]);
                return convex;
            }

            console.log("POINTSTORE")
            console.log(pointStore);
            pointStore.sort();
            var convexHull = convex(pointStore);
            var minX = convexHull.sort(function (a,b) {
                return a[0] < b[0] ? -1 : 1;
            })[0][0];
            var minY = convexHull.sort(function (a,b) {
                return a[1] < b[1] ? -1 : 1;
            })[0][0];
            //svg.append("text").text("BLAH BLAH").attr("text-anchor", "middle").attr("cx", x(0)).attr("y", minY);
            console.log("POINTSTORE")
            console.log(pointStore);
            console.log(convexHull);
            for (i in convexHull) {
                var i = parseInt(i);
                if (i + 1 == convexHull.length) {
                    var nextI = 0;
                } else {
                    var nextI = i + 1;
                }
                console.log(i, ',', nextI);
                svg.append("line")
                    .attr("x2", width)
                    .style("stroke", "#cc0000")
                    .style("stroke-width", "1px")
                    .attr("x1", convexHull[i][0])     // x position of the first end of the line
                    .attr("y1", convexHull[i][1])      // y position of the first end of the line
                    .attr("x2", convexHull[nextI][0])     // x position of the second end of the line
                    .attr("y2", convexHull[nextI][1]);    // y position of the second end of the line
            }*/

            function populateCorpusStats() {
                var wordCounts = {};
                var docCounts = {}
                fullData.docs.labels.forEach(function (x, i) {
                    var cnt = (
                        fullData.docs.texts[i]
                            .trim()
                            .replace(/['";:,.?¿\-!¡]+/g, '')
                            .match(/\S+/g) || []
                    ).length;
                    var name = null;
                    if(unifiedContexts) {
                        var name = fullData.docs.categories[x];
                        wordCounts[name] = wordCounts[name] ? wordCounts[name] + cnt : cnt;
                    } else {
                        if (fullData.docs.categories[x] == fullData.info.category_internal_name) {
                            name = fullData.info.category_name;
                        } else if (fullData.info.not_category_internal_names.indexOf(fullData.docs.categories[x]) > -1) {
                            name = fullData.info.not_category_name;
                        } else if (fullData.info.neutral_category_internal_names.indexOf(fullData.docs.categories[x]) > -1) {
                            name = fullData.info.neutral_category_name;
                        } else if (fullData.info.extra_category_internal_names.indexOf(fullData.docs.categories[x]) > -1) {
                            name = fullData.info.extra_category_name;
                        }
                        if (name) {
                            wordCounts[name] = wordCounts[name] ? wordCounts[name] + cnt : cnt
                        }
                    }
                    //!!!

                });
                fullData.docs.labels.forEach(function (x) {

                    if(unifiedContexts) {
                        var name = fullData.docs.categories[x];
                        docCounts[name] = docCounts[name] ? docCounts[name] + 1 : 1
                    } else {
                        var name = null;
                        if (fullData.docs.categories[x] == fullData.info.category_internal_name) {
                            name = fullData.info.category_name;
                        } else if (fullData.info.not_category_internal_names.indexOf(fullData.docs.categories[x]) > -1) {
                            name = fullData.info.not_category_name;
                        } else if (fullData.info.neutral_category_internal_names.indexOf(fullData.docs.categories[x]) > -1) {
                            name = fullData.info.neutral_category_name;
                        } else if (fullData.info.extra_category_internal_names.indexOf(fullData.docs.categories[x]) > -1) {
                            name = fullData.info.extra_category_name;
                        }
                        if (name) {
                            docCounts[name] = docCounts[name] ? docCounts[name] + 1 : 1
                        }
                    }
                });
                console.log("docCounts");
                console.log(docCounts)
                var messages = [];
                if (unifiedContexts) {
                    fullData.docs.categories.forEach(function (x, i) {
                        if (docCounts[x] > 0) {
                            messages.push('<b>' + x + '</b> document count: '
                                + Number(docCounts[x]).toLocaleString('en')
                                + '; word count: '
                                + Number(wordCounts[x]).toLocaleString('en'));
                        }
                    });
                } else {
                    [fullData.info.category_name,
                     fullData.info.not_category_name,
                     fullData.info.neutral_category_name,
                     fullData.info.extra_category_name].forEach(function (x, i) {
                        if (docCounts[x] > 0) {
                            messages.push('<b>' + x + '</b> document count: '
                                + Number(docCounts[x]).toLocaleString('en')
                                + '; word count: '
                                + Number(wordCounts[x]).toLocaleString('en'));
                        }
                    });
                }

                d3.select('#'+divName+'-'+'corpus-stats')
                    .style('width', width + margin.left + margin.right + 200)
                    .append('div')
                    .html(messages.join('<br />'));
            }


            if (fullData.docs) {
                populateCorpusStats();
            }

            if (saveSvgButton) {
                // from https://stackoverflow.com/questions/23218174/how-do-i-save-export-an-svg-file-after-creating-an-svg-with-d3-js-ie-safari-an
                var svgElement = document.getElementById(divName);

                var serializer = new XMLSerializer();
                var source = serializer.serializeToString(svgElement);

                if (!source.match(/^<svg[^>]+xmlns="http\:\/\/www\.w3\.org\/2000\/svg"/)) {
                    source = source.replace(/^<svg/, '<svg xmlns="https://www.w3.org/2000/svg"');
                }
                if (!source.match(/^<svg[^>]+"http\:\/\/www\.w3\.org\/1999\/xlink"/)) {
                    source = source.replace(/^<svg/, '<svg xmlns:xlink="https://www.w3.org/1999/xlink"');
                }

                source = '<?xml version="1.0" standalone="no"?>\r\n' + source;

                var url = "data:image/svg+xml;charset=utf-8," + encodeURIComponent(source);

                var downloadLink = document.createElement("a");
                downloadLink.href = url;
                downloadLink.download = fullData['info']['category_name'] + ".svg";
                downloadLink.innerText = 'Download SVG';
                document.body.appendChild(downloadLink);

            }
            function rerender(xCoords, yCoords, color) {
                labeledPoints.forEach(function (p) {
                    p.label.remove();
                    rectHolder.remove(p.rect);
                });
                pointRects.forEach(function (rect) {
                    rectHolder.remove(rect);
                });
                pointRects = []
                /*
                var circles = d3.select('#' + divName).selectAll('circle')
                    .attr("cy", function (d) {return y(yCoords[d.i])})
                    .transition(0)
                    .attr("cx", function (d) {return x(xCoords[d.i])})
                    .transition(0);    
                */
                d3.select('#' + divName).selectAll("dot").remove();
                d3.select('#' + divName).selectAll("circle").remove();
                console.log(fullData)
                console.log(this)
                var circles = this.svg//.select('#' + divName)
                .selectAll("dot")
                .data(this.fullData.data.filter(d=>d.display === undefined || d.display === true))
                //.filter(function (d) {return d.display === undefined || d.display === true})
                .enter()
                .append("circle")
                .attr("cy", d=>d.y)
                .attr("cx", d=>d.x)
                .attr("r", d=>2)
                .on("mouseover", function (d) {
                    /*var mySVGMatrix = circle.getScreenCTM()n
                        .translate(circle.cx.baseVal.value, circle.cy.baseVal.value);
                    var pageX = mySVGMatrix.e;
                    var pageY = mySVGMatrix.f;*/

                    /*showTooltip(
                        d,
                        d3.event.pageX,
                        d3.event.pageY
                    );*/
                    console.log("point MOUSOEVER")
                    console.log(d)
                    showToolTipForTerm(data, this, d.term, d, true);
                    d3.select(this).style("stroke", "black");
                })
                .on("click", function (d) {
                    var runDisplayTermContexts = true;
                    if(alternativeTermFunc != null) {
                        runDisplayTermContexts = alternativeTermFunc(d);
                    }
                    if(runDisplayTermContexts) {
                        displayTermContexts(data, gatherTermContexts(d), true, includeAllContexts);
                    }
                })
                .on("mouseout", function (d) {
                    tooltip.transition()
                        .duration(0)
                        .style("opacity", 0);
                    d3.select(this).style("stroke", null);
                    d3.select('#'+divName+'-'+'overlapped-terms')
                        .selectAll('div')
                        .remove();
                })
                
                if(color !== null) {
                     circles.style("fill", d => color(d));
                }
                xCoords.forEach((xCoord,i) => censorCircle(xCoord, yCoords[i]))
                labeledPoints = [];
                labeledPoints = performPartialLabeling(
                    this.fullData.data,
                    labeledPoints, 
                    (d=>d.ox), //function (d) {return xCoords[d.ci]},
                    (d=>d.oy) //function (d) {return yCoords[d.ci]}
                );
            };
            //return [performPartialLabeling, labeledPoints];
            return {...payload, 
                    ...{'rerender': rerender, 
                        'performPartialLabeling': performPartialLabeling,
                        'showToolTipForTerm': showToolTipForTerm,
                        'svg': svg,
                        'data': data,
                        'xLabel': xLabel,
                        'yLabel': yLabel,
                        'drawXLabel': drawXLabel,
                        'drawYLabel': drawYLabel,
                        'populateCorpusStats': populateCorpusStats}};
        };

        
        
        //fullData = getDataAndInfo();
        if (fullData.docs) {
            var corpusWordCounts = getCorpusWordCounts();
        }
        var payload = processData(fullData);
        
        // The tool tip is down here in order to make sure it has the highest z-index
        var tooltip = d3.select('#' + divName)
            .append("div")
            //.attr("class", getTooltipContent == null && sortByDist ? "tooltip" : "tooltipscore")
            .attr("class", "tooltipscore")
            .style("opacity", 0);
        
        plotInterface = {}
        if(payload.topTermsPane) {
            plotInterface.topTermsPane = payload.topTermsPane;
            plotInterface.showTopTermsPane = payload.showTopTermsPane;
            plotInterface.showAssociatedWordList = payload.showAssociatedWordList;
        }
        plotInterface.includeAllContexts = includeAllContexts;
        plotInterface.divName = divName; 
        plotInterface.displayTermContexts = displayTermContexts;
        plotInterface.gatherTermContexts = gatherTermContexts;
        plotInterface.xLabel = payload.xLabel;
        plotInterface.yLabel = payload.yLabel;
        plotInterface.drawXLabel = payload.drawXLabel;
        plotInterface.drawYLabel = payload.drawYLabel;
        plotInterface.svg = payload.svg;
        plotInterface.termDict = termDict;
        plotInterface.showToolTipForTerm = payload.showToolTipForTerm;
        plotInterface.fullData = fullData;
        plotInterface.data = payload.data;
        plotInterface.rerender = payload.rerender;
        plotInterface.populateCorpusStats = payload.populateCorpusStats;
        plotInterface.handleSearch = handleSearch;
        plotInterface.y = y;
        plotInterface.x = x;
        plotInterface.tooltip = tooltip;
        plotInterface.alternativeTermFunc = alternativeTermFunc;
        plotInterface.drawCategoryAssociation = function (categoryNum) {
            var rawLogTermCounts = getTermCounts(this.fullData).map(Math.log);
            var maxRawLogTermCounts = Math.max(...rawLogTermCounts);
            var minRawLogTermCounts = Math.min(...rawLogTermCounts);
            var logTermCounts = rawLogTermCounts.map(
                x => (x - minRawLogTermCounts)/maxRawLogTermCounts
            )
            
            var rawScores = getCategoryDenseRankScores(this.fullData, categoryNum);
            /*
            function logOddsRatioUninformativeDirichletPrior(fgFreqs, bgFreqs, alpha) {
                var fgVocabSize = fgFreqs.reduce((x,y) => x+y);
                var fgL = fgFreqs.map(x => (x + alpha)/((1+alpha)*fgVocabSize - x - alpha))
                var bgVocabSize = bgFreqs.reduce((x,y) => x+y);
                var bgL = bgFreqs.map(x => (x + alpha)/((1+alpha)*bgVocabSize - x - alpha))
                var pooledVar = fgFreqs.map(function(x, i) {
                    return (
                        1/(x + alpha) 
                        + 1/((1+alpha)*fgVocabSize - x - alpha)
                        + 1/(bgFreqs[i] + alpha)
                        + 1/((1+alpha)*bgVocabSize - bgFreqs[i] - alpha))
                })
                return pooledVar.map(function(x, i) {
                    return (Math.log(fgL[i]) - Math.log(bgL[i]))/x;
                })
            }
            var rawScores = logOddsRatioUninformativeDirichletPrior(
                denseRanks.fgFreqs, denseRanks.bgFreqs, 0.01);
            */
                
            var maxRawScores = Math.max(...rawScores);
            var minRawScores = Math.min(...rawScores);
            var scores = rawScores.map(
                function(rawScore) {
                    if(rawScore == 0) {
                        return 0.5;
                    } else if(rawScore > 0) {
                        return rawScore/(2.*maxRawScores) + 0.5;
                    } else if(rawScore < 0) {
                        return 0.5 - rawScore/(2.*minRawScores);
                    }
                }
            )
            
            var denseRanks = getDenseRanks(this.fullData, categoryNum)
            console.log("denseRanks")
            console.log(denseRanks);
            var fgFreqSum = denseRanks.fgFreqs.reduce((a,b) => a + b, 0)
            var bgFreqSum = denseRanks.bgFreqs.reduce((a,b) => a + b, 0)
            
            //!!! OLD and good
            var ox = denseRanks.bg;
            var oy = denseRanks.fg; 
            
            //!!! NEW
            /*
            var oy = denseRanks.fg.map((x,i)=> x - denseRanks.bg[i]);
            var ox = denseRanks.fgFreqs.map((x,i)=> x/fgFreqSum - denseRanks.bgFreqs[i]/bgFreqSum);
            */
            /*
            
            var ox = denseRanks.fg;
            */
            
            /*
            ox = ox.map(function(x) {
                if (x > 0)
                    return 0.5 * x/Math.max(...ox) + 0.5;
                else
                    return 0.5 * (1 + x/Math.min(...ox));
                    
            })
            oy = oy.map(function(x) {
                if (x > 0)
                    return 0.5 * x/Math.max(...oy) + 0.5;
                else
                    return 0.5 * (1 + x/Math.min(...oy));
                    
            })*/
            
            
            
            
            
            var oxmax = Math.max(...ox)
            var oxmin = Math.min(...ox)
            var ox = ox.map(x => (x - oxmin)/(oxmax - oxmin))
            var oymax = Math.max(...oy)
            var oymin = Math.min(...oy)
            var oy = oy.map(x => (x - oymin)/(oymax - oymin))
            //var ox = logTermCounts
            //var oy = scores;
            var xf = this.x;
            var yf = this.y;
            
            this.fullData.data = this.fullData.data.map(function(term, i) { 
                //term.ci = i;
                term.s = scores[i];
                term.os = rawScores[i];
                term.cat = denseRanks.fgFreqs[i];
                term.ncat = denseRanks.bgFreqs[i];
                term.cat25k = parseInt(denseRanks.fgFreqs[i] * 25000/fgFreqSum);
                term.ncat25k = parseInt(25000 *denseRanks.bgFreqs[i]/bgFreqSum);
                term.x = xf(ox[i]) // logTermCounts[term.i];
                term.y = yf(oy[i]) // scores[term.i];
                term.ox = ox[i];
                term.oy = oy[i];
                term.display = false;
                return term;
             })
            
            // Feature selection
            var targetTermsToShow = 1500;
            
            var sortedBg = denseRanks.bg.map((x,i)=>[x,i]).sort((a,b)=>b[0]-a[0]).map(x=>x[1]).slice(0,parseInt(targetTermsToShow/2));
            var sortedFg = denseRanks.fg.map((x,i)=>[x,i]).sort((a,b)=>b[0]-a[0]).map(x=>x[1]).slice(0,parseInt(targetTermsToShow/2));
            var sortedScores = denseRanks.fg.map((x,i)=>[x,i]).sort((a,b)=>b[0]-a[0]).map(x=>x[1]);
            var myFullData = this.fullData
            
            sortedBg.concat(sortedFg)//.concat(sortedScores.slice(0, parseInt(targetTermsToShow/2))).concat(sortedScores.slice(-parseInt(targetTermsToShow/4)))
                .forEach(function(i) {
                myFullData.data[i].display = true;
            })
            
            console.log('newly filtered')
            console.log(myFullData)
            
            // begin rescaling to ignore hidden terms
            /*
            function scaleDenseRanks(ranks) { 
                var max = Math.max(...ranks); 
                return ranks.map(x=>x/max) 
            }
            var filteredData = myFullData.data.filter(d=>d.display);
            var catRanks = scaleDenseRanks(denseRank(filteredData.map(d=>d.cat)))
            var ncatRanks = scaleDenseRanks(denseRank(filteredData.map(d=>d.ncat)))
            var rawScores = catRanks.map((x,i) => x - ncatRanks[i]);
            function stretch_0_1(scores) {
                var max = 1.*Math.max(...rawScores);
                var min = -1.*Math.min(...rawScores);
                return scores.map(function(x, i) {
                    if(x == 0) return 0.5;
                    if(x > 0) return (x/max + 1)/2;
                    return (x/min + 1)/2;
                })
            }
            var scores = stretch_0_1(rawScores);
            console.log(scores)
            filteredData.forEach(function(d, i) {
                d.x = xf(catRanks[i]);
                d.y = yf(ncatRanks[i]);
                d.ox = catRanks[i];
                d.oy = ncatRanks[i];
                d.s = scores[i];
                d.os = rawScores[i];
            });
            console.log("rescaled");
            */
            // end rescaling
            
            
            this.rerender(//denseRanks.bg, 
                          fullData.data.map(x=>x.ox), //ox 
                          //denseRanks.fg, 
                          fullData.data.map(x=>x.oy), //oy,          
                          d => d3.interpolateRdYlBu(d.s));
            this.yLabel.remove()
            this.xLabel.remove()
            this.yLabel = this.drawYLabel(this.svg, this.fullData.info.categories[categoryNum] + ' Frequncy Rank')
            this.xLabel = this.drawXLabel(this.svg,
                               "Not " + this.fullData.info.categories[categoryNum] + ' Frequency Rank')
            console.log(this.topTermsPane)
            this.topTermsPane.catHeader.remove()
            this.topTermsPane.notCatHeader.remove()
            this.topTermsPane.wordListData.wordObjList.map(x => x.remove())
            this.topTermsPane.notWordListData.wordObjList.map(x => x.remove())
            this.showWordList = payload.showWordList;
            this.showAssociatedWordList = function(data, word, header, isAssociatedToCategory, length=14) {
                var sortedData = null;
                if(!isAssociatedToCategory) {
                    sortedData = data.map(x=>x).sort((a, b) => scores[a.i] - scores[b.i])
                } else {
                    sortedData = data.map(x=>x).sort((a, b) => scores[b.i] - scores[a.i])
                }
                console.log('sortedData'); 
                console.log(isAssociatedToCategory); 
                console.log(sortedData.slice(0, length))
                console.log(payload)
                console.log(word)
                return payload.showWordList(word, sortedData.slice(0, length));
            }
            this.topTermsPane = payload.showTopTermsPane(
                this.data,
                this.topTermsPane.registerFigureBBox,
                this.showAssociatedWordList,
                "Top " + this.fullData.info.categories[categoryNum],
                "Top Not " + this.fullData.info.categories[categoryNum],
                this.topTermsPane.startingOffset
            )
            
            fullData.info.category_name = this.fullData.info.categories[categoryNum];
            fullData.info.not_category_name = "Not " + this.fullData.info.categories[categoryNum];
            fullData.info.category_internal_name = this.fullData.info.categories[categoryNum];
            fullData.info.not_category_internal_names = this.fullData.info.categories.filter(x => x!==this.fullData.info.categories[categoryNum]);
            ['snippets', 
             'snippetsalt', 'termstats', 
             'overlapped-terms-clicked', 'categoryinfo', 
             'cathead', 'cat', 'corpus-stats',
             'notcathead', 'notcat', 'neuthead', 'nuet'].forEach(function(divSubName) {
                var mydiv = '#'+divName+'-'+divSubName;
                d3.select(mydiv).selectAll("*").remove();
                d3.select(mydiv).html("");

            })
            this.populateCorpusStats();
            console.log(fullData)
        }
        
        return plotInterface
    };
}(d3);
 
function getDataAndInfo() { return{"info": {"category_name": "most reads", "not_category_name": "least reads", "category_terms": ["neues", "\u201c", "5", "restaurants", "leben", "neuer", "20", "10", "\u201e", "er\u00f6ffnet"], "not_category_terms": ["neues", "\u201c", "5", "restaurants", "leben", "neuer", "20", "10", "\u201e", "er\u00f6ffnet"], "category_internal_name": "most reads", "not_category_internal_names": ["least reads"], "categories": ["least reads", "most reads"], "neutral_category_internal_names": [], "extra_category_internal_names": [], "neutral_category_name": "Neutral", "extra_category_name": "Extra"}, "data": [{"x": 0.9432989690721649, "y": 0.34536082474226804, "ox": 0.9432989690721649, "oy": 0.34536082474226804, "term": "\u201c", "cat25k": 86, "ncat25k": 285, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 40, "s": 0.005154639175257732, "os": -0.6061381074168798, "bg": 0.0}, {"x": 0.9896907216494846, "y": 0.9845360824742269, "ox": 0.9896907216494846, "oy": 0.9845360824742269, "term": "\u00f6sterreich", "cat25k": 557, "ncat25k": 840, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 13, "ncat": 118, "s": 0.4793814432989691, "os": -0.13299232736572897, "bg": 0.0}, {"x": 0.9845360824742269, "y": 0.9896907216494846, "ox": 0.9845360824742269, "oy": 0.9896907216494846, "term": "&", "cat25k": 685, "ncat25k": 798, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 16, "ncat": 112, "s": 0.7010309278350515, "os": -0.052429667519181655, "bg": 0.0}, {"x": 0.17010309278350516, "y": 0.8144329896907216, "ox": 0.17010309278350516, "oy": 0.8144329896907216, "term": "austria", "cat25k": 214, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 10, "s": 0.9278350515463918, "os": 0.11381074168797956, "bg": 1.0565443147262378e-06}, {"x": 0.7835051546391752, "y": 0.9123711340206185, "ox": 0.7835051546391752, "oy": 0.9123711340206185, "term": "zeigt", "cat25k": 300, "ncat25k": 142, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 7, "ncat": 20, "s": 0.7989690721649485, "os": 0.014066496163682884, "bg": 0.0005695121179522876}, {"x": 0.4896907216494845, "y": 0.5515463917525774, "ox": 0.4896907216494845, "oy": 0.5515463917525774, "term": "spricht", "cat25k": 128, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 13, "s": 0.6494845360824743, "os": -0.06905370843989772, "bg": 0.00064342301041541}, {"x": 0.5876288659793815, "y": 0.35051546391752575, "ox": 0.5876288659793815, "oy": 0.35051546391752575, "term": "tod", "cat25k": 86, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 14, "s": 0.4123711340206186, "os": -0.149616368286445, "bg": 2.7888630241210505e-05}, {"x": 0.5927835051546392, "y": 0.3556701030927835, "ox": 0.5927835051546392, "oy": 0.3556701030927835, "term": "vater", "cat25k": 86, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 14, "s": 0.4123711340206186, "os": -0.149616368286445, "bg": 0.00017772742167496987}, {"x": 0.08762886597938144, "y": 0.5567010309278351, "ox": 0.08762886597938144, "oy": 0.5567010309278351, "term": "bekommt", "cat25k": 128, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 9, "s": 0.8092783505154639, "os": 0.01790281329923274, "bg": 0.0006437768240343349}, {"x": 0.4948453608247423, "y": 0.5618556701030928, "ox": 0.4948453608247423, "oy": 0.5618556701030928, "term": "#", "cat25k": 128, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 13, "s": 0.6494845360824743, "os": -0.06905370843989772, "bg": 0.0}, {"x": 0.17525773195876287, "y": 0.9742268041237113, "ox": 0.17525773195876287, "oy": 0.9742268041237113, "term": "meghan", "cat25k": 514, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 12, "ncat": 10, "s": 1.0, "os": 0.5255754475703325, "bg": 5.937144530338134e-05}, {"x": 0.18041237113402062, "y": 0.12371134020618557, "ox": 0.18041237113402062, "oy": 0.12371134020618557, "term": "michael", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 2.5420414954996505e-07}, {"x": 0.9690721649484536, "y": 0.8814432989690721, "ox": 0.9690721649484536, "oy": 0.8814432989690721, "term": "trump", "cat25k": 257, "ncat25k": 321, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 6, "ncat": 45, "s": 0.05670103092783505, "os": -0.4578005115089514, "bg": 3.5216859899045e-05}, {"x": 0.5, "y": 0.8195876288659794, "ox": 0.5, "oy": 0.8195876288659794, "term": "prinz", "cat25k": 214, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 13, "s": 0.8762886597938144, "os": 0.04859335038363172, "bg": 0.00010764101720761261}, {"x": 0.015463917525773196, "y": 0.8247422680412371, "ox": 0.015463917525773196, "oy": 0.8247422680412371, "term": "harry", "cat25k": 214, "ncat25k": 50, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 7, "s": 0.9484536082474226, "os": 0.1790281329923274, "bg": 7.082750518877876e-07}, {"x": 0.09278350515463918, "y": 0.9587628865979382, "ox": 0.09278350515463918, "oy": 0.9587628865979382, "term": "markle", "cat25k": 428, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 10, "ncat": 9, "s": 0.9948453608247423, "os": 0.42966751918158574, "bg": 0.00021526086217640058}, {"x": 0.788659793814433, "y": 0.9175257731958762, "ox": 0.788659793814433, "oy": 0.9175257731958762, "term": "\u00f6vp", "cat25k": 300, "ncat25k": 142, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 7, "ncat": 20, "s": 0.7989690721649485, "os": 0.014066496163682884, "bg": 0.0}, {"x": 0.8969072164948454, "y": 0.9226804123711341, "ox": 0.8969072164948454, "oy": 0.9226804123711341, "term": "fp\u00f6", "cat25k": 300, "ncat25k": 207, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 7, "ncat": 29, "s": 0.3969072164948454, "os": -0.15984654731457804, "bg": 0.0}, {"x": 0.29896907216494845, "y": 0.12886597938144329, "ox": 0.29896907216494845, "oy": 0.12886597938144329, "term": "sch\u00fcler", "cat25k": 43, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 11, "s": 0.4329896907216495, "os": -0.1432225063938619, "bg": 0.0}, {"x": 0.8711340206185567, "y": 0.8865979381443299, "ox": 0.8711340206185567, "oy": 0.8865979381443299, "term": "\u2013", "cat25k": 257, "ncat25k": 185, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 6, "ncat": 26, "s": 0.365979381443299, "os": -0.17519181585677757, "bg": 0.0}, {"x": 0.5051546391752577, "y": 0.8298969072164949, "ox": 0.5051546391752577, "oy": 0.8298969072164949, "term": "lehrer", "cat25k": 214, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 13, "s": 0.8762886597938144, "os": 0.04859335038363172, "bg": 7.580655010707677e-05}, {"x": 0.0979381443298969, "y": 0.5670103092783505, "ox": 0.0979381443298969, "oy": 0.5670103092783505, "term": "familie", "cat25k": 128, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 9, "s": 0.8092783505154639, "os": 0.01790281329923274, "bg": 8.456247052510042e-05}, {"x": 0.979381443298969, "y": 0.9690721649484536, "ox": 0.979381443298969, "oy": 0.9690721649484536, "term": "wiener", "cat25k": 471, "ncat25k": 456, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 11, "ncat": 64, "s": 0.2577319587628866, "os": -0.207161125319693, "bg": 0.0001616820102894431}, {"x": 0.9948453608247423, "y": 1.0, "ox": 0.9948453608247423, "oy": 1.0, "term": "\"", "cat25k": 1027, "ncat25k": 1075, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 24, "ncat": 151, "s": 0.8402061855670103, "os": 0.021739130434782594, "bg": 0.0}, {"x": 0.9742268041237113, "y": 0.979381443298969, "ox": 0.9742268041237113, "oy": 0.979381443298969, "term": "2017", "cat25k": 514, "ncat25k": 377, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 12, "ncat": 53, "s": 0.5051546391752577, "os": -0.1265984654731458, "bg": 0.0}, {"x": 0.8195876288659794, "y": 0.9484536082474226, "ox": 0.8195876288659794, "oy": 0.9484536082474226, "term": "kurier", "cat25k": 342, "ncat25k": 157, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 8, "ncat": 22, "s": 0.8505154639175257, "os": 0.02941176470588236, "bg": 0.0011311577399468356}, {"x": 0.39690721649484534, "y": 0.8350515463917526, "ox": 0.39690721649484534, "oy": 0.8350515463917526, "term": "pleite", "cat25k": 214, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 12, "s": 0.8865979381443299, "os": 0.07033248081841437, "bg": 0.0019753660237043923}, {"x": 0.0, "y": 0.8917525773195877, "ox": 0.0, "oy": 0.8917525773195877, "term": "n\u00f6", "cat25k": 257, "ncat25k": 36, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 6, "ncat": 5, "s": 0.979381443298969, "os": 0.28132992327365725, "bg": 0.0}, {"x": 0.18556701030927836, "y": 0.36082474226804123, "ox": 0.18556701030927836, "oy": 0.36082474226804123, "term": "hochzeit", "cat25k": 86, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 10, "s": 0.6649484536082474, "os": -0.06265984654731457, "bg": 0.0001896978271694713}, {"x": 0.4020618556701031, "y": 0.13402061855670103, "ox": 0.4020618556701031, "oy": 0.13402061855670103, "term": "neu", "cat25k": 43, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 12, "s": 0.37628865979381443, "os": -0.16496163682864448, "bg": 1.2482069027762044e-05}, {"x": 0.6752577319587629, "y": 0.9278350515463918, "ox": 0.6752577319587629, "oy": 0.9278350515463918, "term": "kritik", "cat25k": 300, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 7, "ncat": 16, "s": 0.9226804123711341, "os": 0.10102301790281332, "bg": 0.00015998219328631247}, {"x": 1.0, "y": 0.9948453608247423, "ox": 1.0, "oy": 0.9948453608247423, "term": "wien", "cat25k": 728, "ncat25k": 1132, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 17, "ncat": 159, "s": 0.6907216494845361, "os": -0.05882352941176472, "bg": 0.00019080195239705675}, {"x": 0.04639175257731959, "y": 0.7319587628865979, "ox": 0.04639175257731959, "oy": 0.7319587628865979, "term": "museum", "cat25k": 171, "ncat25k": 57, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 8, "s": 0.9020618556701031, "os": 0.09846547314578005, "bg": 5.08341782750396e-07}, {"x": 0.4072164948453608, "y": 0.5721649484536082, "ox": 0.4072164948453608, "oy": 0.5721649484536082, "term": "rapid", "cat25k": 128, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 12, "s": 0.7061855670103093, "os": -0.04731457800511507, "bg": 1.571677779650985e-06}, {"x": 0.020618556701030927, "y": 0.7371134020618557, "ox": 0.020618556701030927, "oy": 0.7371134020618557, "term": "naddel", "cat25k": 171, "ncat25k": 50, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 7, "s": 0.9329896907216495, "os": 0.12020460358056267, "bg": 0.0012786237359060791}, {"x": 0.9381443298969072, "y": 0.36597938144329895, "ox": 0.9381443298969072, "oy": 0.36597938144329895, "term": "neuer", "cat25k": 86, "ncat25k": 271, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 38, "s": 0.025773195876288662, "os": -0.5843989769820972, "bg": 0.00022515613170507923}, {"x": 0.10309278350515463, "y": 0.5773195876288659, "ox": 0.10309278350515463, "oy": 0.5773195876288659, "term": "koalition", "cat25k": 128, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 9, "s": 0.8092783505154639, "os": 0.01790281329923274, "bg": 0.0013947811937002382}, {"x": 0.9175257731958762, "y": 0.8969072164948454, "ox": 0.9175257731958762, "oy": 0.8969072164948454, "term": "frauen", "cat25k": 257, "ncat25k": 242, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 6, "ncat": 34, "s": 0.16494845360824742, "os": -0.28388746803069054, "bg": 4.405106840360029e-05}, {"x": 0.41237113402061853, "y": 0.8402061855670103, "ox": 0.41237113402061853, "oy": 0.8402061855670103, "term": "europa", "cat25k": 214, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 12, "s": 0.8865979381443299, "os": 0.07033248081841437, "bg": 8.322670931137976e-06}, {"x": 0.6391752577319587, "y": 0.3711340206185567, "ox": 0.6391752577319587, "oy": 0.3711340206185567, "term": "haft", "cat25k": 86, "ncat25k": 107, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 15, "s": 0.3711340206185567, "os": -0.1713554987212276, "bg": 0.00025483244766565983}, {"x": 0.9278350515463918, "y": 0.9536082474226805, "ox": 0.9278350515463918, "oy": 0.9536082474226805, "term": "frau", "cat25k": 385, "ncat25k": 264, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 9, "ncat": 37, "s": 0.4072164948453608, "os": -0.15089514066496157, "bg": 5.2071129162435884e-05}, {"x": 0.5979381443298969, "y": 0.845360824742268, "ox": 0.5979381443298969, "oy": 0.845360824742268, "term": "angelina", "cat25k": 214, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 14, "s": 0.845360824742268, "os": 0.026854219948849123, "bg": 1.1841997832291135e-05}, {"x": 0.6443298969072165, "y": 0.7422680412371134, "ox": 0.6443298969072165, "oy": 0.7422680412371134, "term": "jolie", "cat25k": 171, "ncat25k": 107, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 15, "s": 0.6958762886597938, "os": -0.05370843989769819, "bg": 1.2842922941110466e-05}, {"x": 0.7731958762886598, "y": 0.7474226804123711, "ox": 0.7731958762886598, "oy": 0.7474226804123711, "term": "geld", "cat25k": 171, "ncat25k": 135, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 19, "s": 0.4639175257731959, "os": -0.14066496163682862, "bg": 5.532616578846402e-05}, {"x": 0.10824742268041238, "y": 0.37628865979381443, "ox": 0.10824742268041238, "oy": 0.37628865979381443, "term": "pitt", "cat25k": 86, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 9, "s": 0.7216494845360825, "os": -0.04092071611253195, "bg": 5.327849200556227e-06}, {"x": 0.30412371134020616, "y": 0.38144329896907214, "ox": 0.30412371134020616, "oy": 0.38144329896907214, "term": "sohn", "cat25k": 86, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 11, "s": 0.6237113402061856, "os": -0.08439897698209717, "bg": 9.716357113494524e-05}, {"x": 0.7938144329896907, "y": 0.8505154639175257, "ox": 0.7938144329896907, "oy": 0.8505154639175257, "term": "mann", "cat25k": 214, "ncat25k": 142, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 20, "s": 0.6082474226804124, "os": -0.1035805626598465, "bg": 1.1036263174263258e-05}, {"x": 0.1134020618556701, "y": 0.3865979381443299, "ox": 0.1134020618556701, "oy": 0.3865979381443299, "term": "suche", "cat25k": 86, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 9, "s": 0.7216494845360825, "os": -0.04092071611253195, "bg": 1.1743065986422878e-05}, {"x": 0.30927835051546393, "y": 0.5824742268041238, "ox": 0.30927835051546393, "oy": 0.5824742268041238, "term": "dollar", "cat25k": 128, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 11, "s": 0.7628865979381443, "os": -0.025575447570332477, "bg": 7.933686845196344e-07}, {"x": 0.5103092783505154, "y": 0.13917525773195877, "ox": 0.5103092783505154, "oy": 0.13917525773195877, "term": "2", "cat25k": 43, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 13, "s": 0.3195876288659794, "os": -0.18670076726342713, "bg": 0.0}, {"x": 0.9072164948453608, "y": 0.7525773195876289, "ox": 0.9072164948453608, "oy": 0.7525773195876289, "term": ".", "cat25k": 171, "ncat25k": 221, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 31, "s": 0.07731958762886598, "os": -0.3797953964194373, "bg": 0.0}, {"x": 0.11855670103092783, "y": 0.5876288659793815, "ox": 0.11855670103092783, "oy": 0.5876288659793815, "term": "3", "cat25k": 128, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 9, "s": 0.8092783505154639, "os": 0.01790281329923274, "bg": 0.0}, {"x": 0.9329896907216495, "y": 0.9020618556701031, "ox": 0.9329896907216495, "oy": 0.9020618556701031, "term": "euro", "cat25k": 257, "ncat25k": 264, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 6, "ncat": 37, "s": 0.12371134020618556, "os": -0.3273657289002557, "bg": 3.373632418661821e-06}, {"x": 0.12371134020618557, "y": 0.5927835051546392, "ox": 0.12371134020618557, "oy": 0.5927835051546392, "term": "italien", "cat25k": 128, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 9, "s": 0.8092783505154639, "os": 0.01790281329923274, "bg": 1.8646946484817503e-05}, {"x": 0.8505154639175257, "y": 0.8556701030927835, "ox": 0.8505154639175257, "oy": 0.8556701030927835, "term": "kate", "cat25k": 214, "ncat25k": 171, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 24, "s": 0.31443298969072164, "os": -0.19053708439897693, "bg": 4.4296791865948134e-06}, {"x": 0.9587628865979382, "y": 0.5979381443298969, "ox": 0.9587628865979382, "oy": 0.5979381443298969, "term": "leben", "cat25k": 128, "ncat25k": 306, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 43, "s": 0.020618556701030927, "os": -0.5907928388746804, "bg": 0.0002094133529973957}, {"x": 0.5154639175257731, "y": 0.6030927835051546, "ox": 0.5154639175257731, "oy": 0.6030927835051546, "term": "eu", "cat25k": 128, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 13, "s": 0.6494845360824743, "os": -0.06905370843989772, "bg": 9.053896146152519e-07}, {"x": 0.7268041237113402, "y": 0.6082474226804123, "ox": 0.7268041237113402, "oy": 0.6082474226804123, "term": "2018", "cat25k": 128, "ncat25k": 121, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 17, "s": 0.4020618556701031, "os": -0.15601023017902815, "bg": 0.0}, {"x": 0.6030927835051546, "y": 0.7577319587628866, "ox": 0.6030927835051546, "oy": 0.7577319587628866, "term": "usa", "cat25k": 171, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 14, "s": 0.7577319587628866, "os": -0.031969309462915596, "bg": 1.745632401063156e-07}, {"x": 0.31443298969072164, "y": 0.3917525773195876, "ox": 0.31443298969072164, "oy": 0.3917525773195876, "term": "nimmt", "cat25k": 86, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 11, "s": 0.6237113402061856, "os": -0.08439897698209717, "bg": 0.0005467238623938094}, {"x": 0.4175257731958763, "y": 0.39690721649484534, "ox": 0.4175257731958763, "oy": 0.39690721649484534, "term": "liebe", "cat25k": 86, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 12, "s": 0.5876288659793815, "os": -0.10613810741687976, "bg": 3.218276130390756e-05}, {"x": 0.422680412371134, "y": 0.4020618556701031, "ox": 0.422680412371134, "oy": 0.4020618556701031, "term": "sucht", "cat25k": 86, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 12, "s": 0.5876288659793815, "os": -0.10613810741687976, "bg": 5.968863848083888e-05}, {"x": 0.42783505154639173, "y": 0.6134020618556701, "ox": 0.42783505154639173, "oy": 0.6134020618556701, "term": "mal", "cat25k": 128, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 12, "s": 0.7061855670103093, "os": -0.04731457800511507, "bg": 1.1667620129999166e-05}, {"x": 0.005154639175257732, "y": 0.8608247422680413, "ox": 0.005154639175257732, "oy": 0.8608247422680413, "term": "bundesliga", "cat25k": 214, "ncat25k": 43, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 6, "s": 0.9639175257731959, "os": 0.20076726342711, "bg": 4.775632120033342e-05}, {"x": 0.8402061855670103, "y": 0.6185567010309279, "ox": 0.8402061855670103, "oy": 0.6185567010309279, "term": "\u00f6sterreichs", "cat25k": 128, "ncat25k": 164, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 23, "s": 0.15979381443298968, "os": -0.2864450127877238, "bg": 0.0}, {"x": 0.02577319587628866, "y": 0.7628865979381443, "ox": 0.02577319587628866, "oy": 0.7628865979381443, "term": "erneut", "cat25k": 171, "ncat25k": 50, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 7, "s": 0.9329896907216495, "os": 0.12020460358056267, "bg": 0.0006213811608529869}, {"x": 0.31958762886597936, "y": 0.6237113402061856, "ox": 0.31958762886597936, "oy": 0.6237113402061856, "term": "bleibt", "cat25k": 128, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 11, "s": 0.7628865979381443, "os": -0.025575447570332477, "bg": 0.00038004750593824226}, {"x": 0.4329896907216495, "y": 0.6288659793814433, "ox": 0.4329896907216495, "oy": 0.6288659793814433, "term": "regierung", "cat25k": 128, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 12, "s": 0.7061855670103093, "os": -0.04731457800511507, "bg": 0.0005850804485616773}, {"x": 0.6804123711340206, "y": 0.4072164948453608, "ox": 0.6804123711340206, "oy": 0.4072164948453608, "term": "deutschland", "cat25k": 86, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 16, "s": 0.29896907216494845, "os": -0.1930946291560102, "bg": 6.624266454493866e-06}, {"x": 0.6494845360824743, "y": 0.9639175257731959, "ox": 0.6494845360824743, "oy": 0.9639175257731959, "term": "fu\u00dfball", "cat25k": 428, "ncat25k": 107, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 10, "ncat": 15, "s": 0.9896907216494846, "os": 0.29923273657289007, "bg": 0.0}, {"x": 0.05154639175257732, "y": 0.7680412371134021, "ox": 0.05154639175257732, "oy": 0.7680412371134021, "term": "deutsche", "cat25k": 171, "ncat25k": 57, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 8, "s": 0.9020618556701031, "os": 0.09846547314578005, "bg": 3.726819184671344e-06}, {"x": 0.19072164948453607, "y": 0.634020618556701, "ox": 0.19072164948453607, "oy": 0.634020618556701, "term": "tote", "cat25k": 128, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 10, "s": 0.7783505154639175, "os": -0.0038363171355498826, "bg": 6.8798339102250475e-06}, {"x": 0.6082474226804123, "y": 0.41237113402061853, "ox": 0.6082474226804123, "oy": 0.41237113402061853, "term": "prozent", "cat25k": 86, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 14, "s": 0.4123711340206186, "os": -0.149616368286445, "bg": 0.0007582579024690774}, {"x": 0.9123711340206185, "y": 0.4175257731958763, "ox": 0.9123711340206185, "oy": 0.4175257731958763, "term": "\u201e", "cat25k": 86, "ncat25k": 221, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 31, "s": 0.041237113402061855, "os": -0.4974424552429667, "bg": 0.0}, {"x": 0.6134020618556701, "y": 0.6391752577319587, "ox": 0.6134020618556701, "oy": 0.6391752577319587, "term": "letzte", "cat25k": 128, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 14, "s": 0.6134020618556701, "os": -0.09079283887468031, "bg": 8.989453256165046e-05}, {"x": 0.030927835051546393, "y": 0.865979381443299, "ox": 0.030927835051546393, "oy": 0.865979381443299, "term": "ski", "cat25k": 214, "ncat25k": 50, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 7, "s": 0.9484536082474226, "os": 0.1790281329923274, "bg": 8.367907026416472e-07}, {"x": 0.03608247422680412, "y": 0.8711340206185567, "ox": 0.03608247422680412, "oy": 0.8711340206185567, "term": "alpin", "cat25k": 214, "ncat25k": 50, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 7, "s": 0.9484536082474226, "os": 0.1790281329923274, "bg": 0.0001849055440845635}, {"x": 0.1958762886597938, "y": 0.422680412371134, "ox": 0.1958762886597938, "oy": 0.422680412371134, "term": "paris", "cat25k": 86, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 10, "s": 0.6649484536082474, "os": -0.06265984654731457, "bg": 4.913134150507642e-07}, {"x": 0.9639175257731959, "y": 0.9329896907216495, "ox": 0.9639175257731959, "oy": 0.9329896907216495, "term": "welt", "cat25k": 300, "ncat25k": 313, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 7, "ncat": 44, "s": 0.08247422680412371, "os": -0.3772378516624041, "bg": 9.996883324610562e-05}, {"x": 0.9536082474226805, "y": 0.42783505154639173, "ox": 0.9536082474226805, "oy": 0.42783505154639173, "term": "neues", "cat25k": 86, "ncat25k": 299, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 42, "s": 0.0, "os": -0.6278772378516624, "bg": 0.00029385247270177317}, {"x": 0.520618556701031, "y": 0.4329896907216495, "ox": 0.520618556701031, "oy": 0.4329896907216495, "term": "fall", "cat25k": 86, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 13, "s": 0.4845360824742268, "os": -0.1278772378516624, "bg": 4.578871985728572e-07}, {"x": 0.20103092783505155, "y": 0.9381443298969072, "ox": 0.20103092783505155, "oy": 0.9381443298969072, "term": "heidi", "cat25k": 300, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 7, "ncat": 10, "s": 0.9690721649484536, "os": 0.23145780051150894, "bg": 1.1620507050571764e-05}, {"x": 0.041237113402061855, "y": 0.9432989690721649, "ox": 0.041237113402061855, "oy": 0.9432989690721649, "term": "strobl", "cat25k": 300, "ncat25k": 50, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 7, "ncat": 7, "s": 0.9845360824742269, "os": 0.2966751918158568, "bg": 0.0003115819460518116}, {"x": 0.845360824742268, "y": 0.7731958762886598, "ox": 0.845360824742268, "oy": 0.7731958762886598, "term": "millionen", "cat25k": 171, "ncat25k": 164, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 23, "s": 0.211340206185567, "os": -0.22762148337595906, "bg": 0.000845493831026492}, {"x": 0.9484536082474226, "y": 0.4381443298969072, "ox": 0.9484536082474226, "oy": 0.4381443298969072, "term": "5", "cat25k": 86, "ncat25k": 285, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 40, "s": 0.005154639175257732, "os": -0.6061381074168798, "bg": 0.0}, {"x": 0.05670103092783505, "y": 0.6443298969072165, "ox": 0.05670103092783505, "oy": 0.6443298969072165, "term": "sex", "cat25k": 128, "ncat25k": 57, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 8, "s": 0.8556701030927835, "os": 0.039641943734015334, "bg": 6.872354036315487e-08}, {"x": 0.4381443298969072, "y": 0.14432989690721648, "ox": 0.4381443298969072, "oy": 0.14432989690721648, "term": "christian", "cat25k": 43, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 12, "s": 0.37628865979381443, "os": -0.16496163682864448, "bg": 4.2009826356906893e-07}, {"x": 0.7989690721649485, "y": 0.6494845360824743, "ox": 0.7989690721649485, "oy": 0.6494845360824743, "term": "\u00f6sterreicher", "cat25k": 128, "ncat25k": 150, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 21, "s": 0.20103092783505153, "os": -0.24296675191815859, "bg": 0.0}, {"x": 0.44329896907216493, "y": 0.44329896907216493, "ox": 0.44329896907216493, "oy": 0.44329896907216493, "term": "erstmals", "cat25k": 86, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 12, "s": 0.5876288659793815, "os": -0.10613810741687976, "bg": 0.0007030053478621106}, {"x": 0.3247422680412371, "y": 0.654639175257732, "ox": 0.3247422680412371, "oy": 0.654639175257732, "term": "wissen", "cat25k": 128, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 11, "s": 0.7628865979381443, "os": -0.025575447570332477, "bg": 0.00010775032709920726}, {"x": 0.12886597938144329, "y": 0.8762886597938144, "ox": 0.12886597938144329, "oy": 0.8762886597938144, "term": "herzogin", "cat25k": 214, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 5, "ncat": 9, "s": 0.9432989690721649, "os": 0.13554987212276218, "bg": 0.0016270556104363996}, {"x": 0.20618556701030927, "y": 0.14948453608247422, "ox": 0.20618556701030927, "oy": 0.14948453608247422, "term": "netz", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 7.183087094931027e-05}, {"x": 0.5257731958762887, "y": 0.4484536082474227, "ox": 0.5257731958762887, "oy": 0.4484536082474227, "term": "florian", "cat25k": 86, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 13, "s": 0.4845360824742268, "os": -0.1278772378516624, "bg": 3.231988933669891e-05}, {"x": 0.5309278350515464, "y": 0.15463917525773196, "ox": 0.5309278350515464, "oy": 0.15463917525773196, "term": "holzer", "cat25k": 43, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 13, "s": 0.3195876288659794, "os": -0.18670076726342713, "bg": 0.00014173196460750368}, {"x": 0.5360824742268041, "y": 0.15979381443298968, "ox": 0.5360824742268041, "oy": 0.15979381443298968, "term": ":", "cat25k": 43, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 13, "s": 0.3195876288659794, "os": -0.18670076726342713, "bg": 0.0}, {"x": 0.061855670103092786, "y": 0.6597938144329897, "ox": 0.061855670103092786, "oy": 0.6597938144329897, "term": "new", "cat25k": 128, "ncat25k": 57, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 8, "s": 0.8556701030927835, "os": 0.039641943734015334, "bg": 1.5471136226352006e-08}, {"x": 0.6185567010309279, "y": 0.6649484536082474, "ox": 0.6185567010309279, "oy": 0.6649484536082474, "term": "m\u00e4nner", "cat25k": 128, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 14, "s": 0.6134020618556701, "os": -0.09079283887468031, "bg": 0.0}, {"x": 0.211340206185567, "y": 0.16494845360824742, "ox": 0.211340206185567, "oy": 0.16494845360824742, "term": "verurteilt", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 0.0012786237359060791}, {"x": 0.21649484536082475, "y": 0.17010309278350516, "ox": 0.21649484536082475, "oy": 0.17010309278350516, "term": "gesund", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 0.0006777363605557439}, {"x": 0.7783505154639175, "y": 0.17525773195876287, "ox": 0.7783505154639175, "oy": 0.17525773195876287, "term": "paaradox", "cat25k": 43, "ncat25k": 135, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 19, "s": 0.12886597938144329, "os": -0.3171355498721228, "bg": 0.0023235550392099913}, {"x": 0.7577319587628866, "y": 0.18041237113402062, "ox": 0.7577319587628866, "oy": 0.18041237113402062, "term": "polizei", "cat25k": 43, "ncat25k": 128, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 18, "s": 0.14432989690721648, "os": -0.2953964194373402, "bg": 0.0005105331040412725}, {"x": 0.9020618556701031, "y": 0.6701030927835051, "ox": 0.9020618556701031, "oy": 0.6701030927835051, "term": "kinder", "cat25k": 128, "ncat25k": 214, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 30, "s": 0.07216494845360825, "os": -0.41687979539641945, "bg": 4.980974187988003e-05}, {"x": 0.5412371134020618, "y": 0.4536082474226804, "ox": 0.5412371134020618, "oy": 0.4536082474226804, "term": "weihnachten", "cat25k": 86, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 13, "s": 0.4845360824742268, "os": -0.1278772378516624, "bg": 0.00026869682042095835}, {"x": 0.06701030927835051, "y": 0.6752577319587629, "ox": 0.06701030927835051, "oy": 0.6752577319587629, "term": "handel", "cat25k": 128, "ncat25k": 57, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 8, "s": 0.8556701030927835, "os": 0.039641943734015334, "bg": 1.460485647990098e-05}, {"x": 0.22164948453608246, "y": 0.4587628865979381, "ox": 0.22164948453608246, "oy": 0.4587628865979381, "term": "hilft", "cat25k": 86, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 10, "s": 0.6649484536082474, "os": -0.06265984654731457, "bg": 0.0005369728157512026}, {"x": 0.13402061855670103, "y": 0.7783505154639175, "ox": 0.13402061855670103, "oy": 0.7783505154639175, "term": "streit", "cat25k": 171, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 9, "s": 0.8969072164948454, "os": 0.07672634271099746, "bg": 0.0002585469660507945}, {"x": 0.8041237113402062, "y": 0.18556701030927836, "ox": 0.8041237113402062, "oy": 0.18556701030927836, "term": "sp\u00f6", "cat25k": 43, "ncat25k": 150, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 21, "s": 0.08762886597938145, "os": -0.36061381074168797, "bg": 0.0}, {"x": 0.4484536082474227, "y": 0.19072164948453607, "ox": 0.4484536082474227, "oy": 0.19072164948453607, "term": "\u00f6bb", "cat25k": 43, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 12, "s": 0.37628865979381443, "os": -0.16496163682864448, "bg": 0.0}, {"x": 0.32989690721649484, "y": 0.4639175257731959, "ox": 0.32989690721649484, "oy": 0.4639175257731959, "term": "4", "cat25k": 86, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 11, "s": 0.6237113402061856, "os": -0.08439897698209717, "bg": 0.0}, {"x": 0.010309278350515464, "y": 0.9072164948453608, "ox": 0.010309278350515464, "oy": 0.9072164948453608, "term": "haut", "cat25k": 257, "ncat25k": 43, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 6, "ncat": 6, "s": 0.9742268041237113, "os": 0.25959079283887465, "bg": 2.492644103390723e-05}, {"x": 0.8247422680412371, "y": 0.7835051546391752, "ox": 0.8247422680412371, "oy": 0.7835051546391752, "term": "salz", "cat25k": 171, "ncat25k": 157, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 22, "s": 0.26288659793814434, "os": -0.20588235294117646, "bg": 0.0004095778197857593}, {"x": 0.8092783505154639, "y": 0.788659793814433, "ox": 0.8092783505154639, "oy": 0.788659793814433, "term": "pfeffer", "cat25k": 171, "ncat25k": 150, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 21, "s": 0.36082474226804123, "os": -0.18414322250639387, "bg": 0.0002574824396976126}, {"x": 0.33505154639175255, "y": 0.1958762886597938, "ox": 0.33505154639175255, "oy": 0.1958762886597938, "term": "the", "cat25k": 43, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 11, "s": 0.4329896907216495, "os": -0.1432225063938619, "bg": 1.0373503002877495e-09}, {"x": 0.13917525773195877, "y": 0.4690721649484536, "ox": 0.13917525773195877, "oy": 0.4690721649484536, "term": "wiens", "cat25k": 86, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 9, "s": 0.7216494845360825, "os": -0.04092071611253195, "bg": 0.00017550577573552875}, {"x": 0.14432989690721648, "y": 0.4742268041237113, "ox": 0.14432989690721648, "oy": 0.4742268041237113, "term": "1", "cat25k": 86, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 9, "s": 0.7216494845360825, "os": -0.04092071611253195, "bg": 0.0}, {"x": 0.5463917525773195, "y": 0.20103092783505155, "ox": 0.5463917525773195, "oy": 0.20103092783505155, "term": "ludwig", "cat25k": 43, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 13, "s": 0.3195876288659794, "os": -0.18670076726342713, "bg": 1.175329826932683e-05}, {"x": 0.3402061855670103, "y": 0.20618556701030927, "ox": 0.3402061855670103, "oy": 0.20618556701030927, "term": "druck", "cat25k": 43, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 11, "s": 0.4329896907216495, "os": -0.1432225063938619, "bg": 0.00013363847451681337}, {"x": 0.2268041237113402, "y": 0.4793814432989691, "ox": 0.2268041237113402, "oy": 0.4793814432989691, "term": "liste", "cat25k": 86, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 10, "s": 0.6649484536082474, "os": -0.06265984654731457, "bg": 1.633214131385272e-05}, {"x": 0.6855670103092784, "y": 0.4845360824742268, "ox": 0.6855670103092784, "oy": 0.4845360824742268, "term": "pilz", "cat25k": 86, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 16, "s": 0.29896907216494845, "os": -0.1930946291560102, "bg": 0.0003327141153963457}, {"x": 0.7319587628865979, "y": 0.4896907216494845, "ox": 0.7319587628865979, "oy": 0.4896907216494845, "term": "salzburg", "cat25k": 86, "ncat25k": 121, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 17, "s": 0.2422680412371134, "os": -0.21483375959079284, "bg": 1.847832006784461e-05}, {"x": 0.14948453608247422, "y": 0.4948453608247423, "ox": 0.14948453608247422, "oy": 0.4948453608247423, "term": "7", "cat25k": 86, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 9, "s": 0.7216494845360825, "os": -0.04092071611253195, "bg": 0.0}, {"x": 0.7628865979381443, "y": 0.7938144329896907, "ox": 0.7628865979381443, "oy": 0.7938144329896907, "term": "tipps", "cat25k": 171, "ncat25k": 128, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 18, "s": 0.577319587628866, "os": -0.11892583120204603, "bg": 0.0001663616702711695}, {"x": 0.15463917525773196, "y": 0.5, "ox": 0.15463917525773196, "oy": 0.5, "term": "sexuelle", "cat25k": 86, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 9, "s": 0.7216494845360825, "os": -0.04092071611253195, "bg": 0.00040390688110450174}, {"x": 0.07216494845360824, "y": 0.6804123711340206, "ox": 0.07216494845360824, "oy": 0.6804123711340206, "term": "bel\u00e4stigung", "cat25k": 128, "ncat25k": 57, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 8, "s": 0.8556701030927835, "os": 0.039641943734015334, "bg": 0.0}, {"x": 0.4536082474226804, "y": 0.5051546391752577, "ox": 0.4536082474226804, "oy": 0.5051546391752577, "term": "mindestsicherung", "cat25k": 86, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 12, "s": 0.5876288659793815, "os": -0.10613810741687976, "bg": 0.0016270556104363996}, {"x": 0.5515463917525774, "y": 0.211340206185567, "ox": 0.5515463917525774, "oy": 0.211340206185567, "term": "fragen", "cat25k": 43, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 13, "s": 0.3195876288659794, "os": -0.18670076726342713, "bg": 9.754704031828207e-05}, {"x": 0.07731958762886598, "y": 0.7989690721649485, "ox": 0.07731958762886598, "oy": 0.7989690721649485, "term": "millionen-pleite", "cat25k": 171, "ncat25k": 57, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 8, "s": 0.9020618556701031, "os": 0.09846547314578005, "bg": 0.0}, {"x": 0.15979381443298968, "y": 0.5103092783505154, "ox": 0.15979381443298968, "oy": 0.5103092783505154, "term": "lebensmittel", "cat25k": 86, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 9, "s": 0.7216494845360825, "os": -0.04092071611253195, "bg": 0.0005700663349917081}, {"x": 0.6907216494845361, "y": 0.6855670103092784, "ox": 0.6907216494845361, "oy": 0.6855670103092784, "term": "fast", "cat25k": 128, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 16, "s": 0.4690721649484536, "os": -0.1342710997442455, "bg": 4.044330717864658e-07}, {"x": 0.8917525773195877, "y": 0.21649484536082475, "ox": 0.8917525773195877, "oy": 0.21649484536082475, "term": "er\u00f6ffnet", "cat25k": 43, "ncat25k": 199, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 28, "s": 0.04639175257731958, "os": -0.49104859335038364, "bg": 0.0}, {"x": 0.4587628865979381, "y": 0.22164948453608246, "ox": 0.4587628865979381, "oy": 0.22164948453608246, "term": "stadt", "cat25k": 43, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 12, "s": 0.37628865979381443, "os": -0.16496163682864448, "bg": 5.4205400942757016e-05}, {"x": 0.8298969072164949, "y": 0.8041237113402062, "ox": 0.8298969072164949, "oy": 0.8041237113402062, "term": "fl\u00fcchtlinge", "cat25k": 171, "ncat25k": 157, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 22, "s": 0.26288659793814434, "os": -0.20588235294117646, "bg": 0.0}, {"x": 0.23195876288659795, "y": 0.6907216494845361, "ox": 0.23195876288659795, "oy": 0.6907216494845361, "term": "stellt", "cat25k": 128, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 10, "s": 0.7783505154639175, "os": -0.0038363171355498826, "bg": 0.0002804322971719482}, {"x": 0.8762886597938144, "y": 0.6958762886597938, "ox": 0.8762886597938144, "oy": 0.6958762886597938, "term": "interview", "cat25k": 128, "ncat25k": 185, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 26, "s": 0.10309278350515465, "os": -0.35166240409207167, "bg": 1.7874766672657795e-06}, {"x": 0.16494845360824742, "y": 0.7010309278350515, "ox": 0.16494845360824742, "oy": 0.7010309278350515, "term": "orf", "cat25k": 128, "ncat25k": 64, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 9, "s": 0.8092783505154639, "os": 0.01790281329923274, "bg": 1.450414848863751e-05}, {"x": 0.34536082474226804, "y": 0.2268041237113402, "ox": 0.34536082474226804, "oy": 0.2268041237113402, "term": "weinstein", "cat25k": 43, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 11, "s": 0.4329896907216495, "os": -0.1432225063938619, "bg": 2.9263790561302014e-05}, {"x": 0.654639175257732, "y": 0.7061855670103093, "ox": 0.654639175257732, "oy": 0.7061855670103093, "term": "freundin", "cat25k": 128, "ncat25k": 107, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 15, "s": 0.5824742268041238, "os": -0.11253196930946291, "bg": 0.0003123291949715}, {"x": 0.23711340206185566, "y": 0.711340206185567, "ox": 0.23711340206185566, "oy": 0.711340206185567, "term": "stars", "cat25k": 128, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 10, "s": 0.7783505154639175, "os": -0.0038363171355498826, "bg": 4.45434672371063e-07}, {"x": 0.8814432989690721, "y": 0.7164948453608248, "ox": 0.8814432989690721, "oy": 0.7164948453608248, "term": "'s", "cat25k": 128, "ncat25k": 185, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 26, "s": 0.10309278350515465, "os": -0.35166240409207167, "bg": 0.0}, {"x": 0.35051546391752575, "y": 0.23195876288659795, "ox": 0.35051546391752575, "oy": 0.23195876288659795, "term": "l\u00e4uft", "cat25k": 43, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 11, "s": 0.4329896907216495, "os": -0.1432225063938619, "bg": 0.0}, {"x": 0.5567010309278351, "y": 0.23711340206185566, "ox": 0.5567010309278351, "oy": 0.23711340206185566, "term": "trumps", "cat25k": 43, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 13, "s": 0.3195876288659794, "os": -0.18670076726342713, "bg": 4.692703349081822e-05}, {"x": 0.2422680412371134, "y": 0.2422680412371134, "ox": 0.2422680412371134, "oy": 0.2422680412371134, "term": "l\u00e4sst", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 0.0}, {"x": 0.6958762886597938, "y": 0.5154639175257731, "ox": 0.6958762886597938, "oy": 0.5154639175257731, "term": "gestorben", "cat25k": 86, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 16, "s": 0.29896907216494845, "os": -0.1930946291560102, "bg": 0.002091442514378667}, {"x": 0.6237113402061856, "y": 0.520618556701031, "ox": 0.6237113402061856, "oy": 0.520618556701031, "term": "victoria", "cat25k": 86, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 14, "s": 0.4123711340206186, "os": -0.149616368286445, "bg": 1.2060363930526877e-06}, {"x": 0.3556701030927835, "y": 0.24742268041237114, "ox": 0.3556701030927835, "oy": 0.24742268041237114, "term": "aff\u00e4re", "cat25k": 43, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 11, "s": 0.4329896907216495, "os": -0.1432225063938619, "bg": 0.0}, {"x": 0.36082474226804123, "y": 0.5257731958762887, "ox": 0.36082474226804123, "oy": 0.5257731958762887, "term": "\u2019s", "cat25k": 86, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 11, "s": 0.6237113402061856, "os": -0.08439897698209717, "bg": 0.0}, {"x": 0.9226804123711341, "y": 0.25257731958762886, "ox": 0.9226804123711341, "oy": 0.25257731958762886, "term": "restaurants", "cat25k": 43, "ncat25k": 256, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 36, "s": 0.015463917525773196, "os": -0.5997442455242966, "bg": 1.4335243771929617e-06}, {"x": 0.24742268041237114, "y": 0.7216494845360825, "ox": 0.24742268041237114, "oy": 0.7216494845360825, "term": "beste", "cat25k": 128, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 10, "s": 0.7783505154639175, "os": -0.0038363171355498826, "bg": 4.2627842539307795e-05}, {"x": 0.7371134020618557, "y": 0.5309278350515464, "ox": 0.7371134020618557, "oy": 0.5309278350515464, "term": "studie", "cat25k": 86, "ncat25k": 121, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 17, "s": 0.2422680412371134, "os": -0.21483375959079284, "bg": 8.123528946485183e-05}, {"x": 0.5618556701030928, "y": 0.25773195876288657, "ox": 0.5618556701030928, "oy": 0.25773195876288657, "term": "van", "cat25k": 43, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 13, "s": 0.3195876288659794, "os": -0.18670076726342713, "bg": 5.075724921377928e-07}, {"x": 0.25257731958762886, "y": 0.26288659793814434, "ox": 0.25257731958762886, "oy": 0.26288659793814434, "term": "bellen", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 8.75851965093318e-05}, {"x": 0.6597938144329897, "y": 0.26804123711340205, "ox": 0.6597938144329897, "oy": 0.26804123711340205, "term": "arzt", "cat25k": 43, "ncat25k": 107, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 15, "s": 0.20618556701030927, "os": -0.23017902813299232, "bg": 0.0003818342362122044}, {"x": 0.5670103092783505, "y": 0.5360824742268041, "ox": 0.5670103092783505, "oy": 0.5360824742268041, "term": "gr\u00fcne", "cat25k": 86, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 13, "s": 0.4845360824742268, "os": -0.1278772378516624, "bg": 0.0}, {"x": 0.36597938144329895, "y": 0.5412371134020618, "ox": 0.36597938144329895, "oy": 0.5412371134020618, "term": "droht", "cat25k": 86, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 11, "s": 0.6237113402061856, "os": -0.08439897698209717, "bg": 0.0015109251510925152}, {"x": 0.25773195876288657, "y": 0.27319587628865977, "ox": 0.25773195876288657, "oy": 0.27319587628865977, "term": "wolfgang", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 7.056694445451271e-06}, {"x": 0.26288659793814434, "y": 0.27835051546391754, "ox": 0.26288659793814434, "oy": 0.27835051546391754, "term": "eigentlich", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 0.00024067388688327315}, {"x": 0.26804123711340205, "y": 0.28350515463917525, "ox": 0.26804123711340205, "oy": 0.28350515463917525, "term": "tot", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 4.64504762968498e-06}, {"x": 0.8144329896907216, "y": 0.28865979381443296, "ox": 0.8144329896907216, "oy": 0.28865979381443296, "term": "kern", "cat25k": 43, "ncat25k": 150, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 21, "s": 0.08762886597938145, "os": -0.36061381074168797, "bg": 1.833532730017723e-05}, {"x": 0.08247422680412371, "y": 0.8092783505154639, "ox": 0.08247422680412371, "oy": 0.8092783505154639, "term": "jahreshoroskop", "cat25k": 171, "ncat25k": 57, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 4, "ncat": 8, "s": 0.9020618556701031, "os": 0.09846547314578005, "bg": 0.0013947811937002382}, {"x": 0.7422680412371134, "y": 0.29381443298969073, "ox": 0.7422680412371134, "oy": 0.29381443298969073, "term": "weg", "cat25k": 43, "ncat25k": 121, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 17, "s": 0.17010309278350513, "os": -0.2736572890025576, "bg": 6.730104129666673e-05}, {"x": 0.7010309278350515, "y": 0.7268041237113402, "ox": 0.7010309278350515, "oy": 0.7268041237113402, "term": "zukunft", "cat25k": 128, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 3, "ncat": 16, "s": 0.4690721649484536, "os": -0.1342710997442455, "bg": 0.0002705107670403987}, {"x": 0.8608247422680413, "y": 0.29896907216494845, "ox": 0.8608247422680413, "oy": 0.29896907216494845, "term": "peter", "cat25k": 43, "ncat25k": 178, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 25, "s": 0.06185567010309278, "os": -0.44757033248081834, "bg": 8.730843605674537e-07}, {"x": 0.27319587628865977, "y": 0.5463917525773195, "ox": 0.27319587628865977, "oy": 0.5463917525773195, "term": "zeiten", "cat25k": 86, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 2, "ncat": 10, "s": 0.6649484536082474, "os": -0.06265984654731457, "bg": 0.0003170367630546492}, {"x": 0.6288659793814433, "y": 0.30412371134020616, "ox": 0.6288659793814433, "oy": 0.30412371134020616, "term": "woche", "cat25k": 43, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 14, "s": 0.25257731958762886, "os": -0.20843989769820973, "bg": 0.00017821711597181794}, {"x": 0.27835051546391754, "y": 0.30927835051546393, "ox": 0.27835051546391754, "oy": 0.30927835051546393, "term": "2016", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 0.0}, {"x": 0.7061855670103093, "y": 0.31443298969072164, "ox": 0.7061855670103093, "oy": 0.31443298969072164, "term": "sieht", "cat25k": 43, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 16, "s": 0.18041237113402062, "os": -0.2519181585677749, "bg": 0.0004129822174715771}, {"x": 0.5721649484536082, "y": 0.31958762886597936, "ox": 0.5721649484536082, "oy": 0.31958762886597936, "term": "juli", "cat25k": 43, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 13, "s": 0.3195876288659794, "os": -0.18670076726342713, "bg": 3.2811051699671076e-05}, {"x": 0.28350515463917525, "y": 0.3247422680412371, "ox": 0.28350515463917525, "oy": 0.3247422680412371, "term": "1914", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 0.0}, {"x": 0.28865979381443296, "y": 0.32989690721649484, "ox": 0.28865979381443296, "oy": 0.32989690721649484, "term": "steht", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 8.173364491189484e-05}, {"x": 0.711340206185567, "y": 0.33505154639175255, "ox": 0.711340206185567, "oy": 0.33505154639175255, "term": "haus", "cat25k": 43, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 16, "s": 0.18041237113402062, "os": -0.2519181585677749, "bg": 3.302237265747544e-05}, {"x": 0.29381443298969073, "y": 0.3402061855670103, "ox": 0.29381443298969073, "oy": 0.3402061855670103, "term": "kunst", "cat25k": 43, "ncat25k": 71, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 1, "ncat": 10, "s": 0.5103092783505154, "os": -0.12148337595907929, "bg": 2.181304043047044e-05}, {"x": 0.3711340206185567, "y": 0.0, "ox": 0.3711340206185567, "oy": 0.0, "term": "warnt", "cat25k": 0, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 11, "s": 0.2731958762886598, "os": -0.20204603580562658, "bg": 0.0012786237359060791}, {"x": 0.6649484536082474, "y": 0.005154639175257732, "ox": 0.6649484536082474, "oy": 0.005154639175257732, "term": "essen", "cat25k": 0, "ncat25k": 107, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 15, "s": 0.14948453608247422, "os": -0.289002557544757, "bg": 2.746216628890931e-05}, {"x": 0.865979381443299, "y": 0.010309278350515464, "ox": 0.865979381443299, "oy": 0.010309278350515464, "term": "10", "cat25k": 0, "ncat25k": 178, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 25, "s": 0.03608247422680412, "os": -0.5063938618925831, "bg": 0.0}, {"x": 0.8865979381443299, "y": 0.015463917525773196, "ox": 0.8865979381443299, "oy": 0.015463917525773196, "term": "20", "cat25k": 0, "ncat25k": 185, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 26, "s": 0.03092783505154639, "os": -0.5281329923273658, "bg": 0.0}, {"x": 0.7680412371134021, "y": 0.020618556701030927, "ox": 0.7680412371134021, "oy": 0.020618556701030927, "term": "fakten", "cat25k": 0, "ncat25k": 128, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 18, "s": 0.0979381443298969, "os": -0.35421994884910485, "bg": 0.0007490169152986704}, {"x": 0.37628865979381443, "y": 0.02577319587628866, "ox": 0.37628865979381443, "oy": 0.02577319587628866, "term": "30", "cat25k": 0, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 11, "s": 0.2731958762886598, "os": -0.20204603580562658, "bg": 0.0}, {"x": 0.634020618556701, "y": 0.030927835051546393, "ox": 0.634020618556701, "oy": 0.030927835051546393, "term": "melania", "cat25k": 0, "ncat25k": 100, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 14, "s": 0.17525773195876287, "os": -0.2672634271099744, "bg": 0.00046081432474243773}, {"x": 0.7164948453608248, "y": 0.03608247422680412, "ox": 0.7164948453608248, "oy": 0.03608247422680412, "term": "land", "cat25k": 0, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 16, "s": 0.13402061855670103, "os": -0.3107416879795396, "bg": 3.102273904726687e-07}, {"x": 0.38144329896907214, "y": 0.041237113402061855, "ox": 0.38144329896907214, "oy": 0.041237113402061855, "term": "george", "cat25k": 0, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 11, "s": 0.2731958762886598, "os": -0.20204603580562658, "bg": 3.222065784419165e-07}, {"x": 0.6701030927835051, "y": 0.04639175257731959, "ox": 0.6701030927835051, "oy": 0.04639175257731959, "term": "promis", "cat25k": 0, "ncat25k": 107, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 15, "s": 0.14948453608247422, "os": -0.289002557544757, "bg": 0.0002782131298049726}, {"x": 0.8556701030927835, "y": 0.05154639175257732, "ox": 0.8556701030927835, "oy": 0.05154639175257732, "term": "strache", "cat25k": 0, "ncat25k": 171, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 24, "s": 0.05154639175257732, "os": -0.48465473145780047, "bg": 0.0027876183285905102}, {"x": 0.5773195876288659, "y": 0.05670103092783505, "ox": 0.5773195876288659, "oy": 0.05670103092783505, "term": "schulen", "cat25k": 0, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 13, "s": 0.19072164948453607, "os": -0.24552429667519182, "bg": 0.0003858482725869643}, {"x": 0.7474226804123711, "y": 0.061855670103092786, "ox": 0.7474226804123711, "oy": 0.061855670103092786, "term": "wichtigsten", "cat25k": 0, "ncat25k": 121, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 17, "s": 0.1134020618556701, "os": -0.33248081841432225, "bg": 0.0008034216309459109}, {"x": 0.3865979381443299, "y": 0.06701030927835051, "ox": 0.3865979381443299, "oy": 0.06701030927835051, "term": "star", "cat25k": 0, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 11, "s": 0.2731958762886598, "os": -0.20204603580562658, "bg": 1.7956927403864485e-07}, {"x": 0.7216494845360825, "y": 0.07216494845360824, "ox": 0.7216494845360825, "oy": 0.07216494845360824, "term": "thomas", "cat25k": 0, "ncat25k": 114, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 16, "s": 0.13402061855670103, "os": -0.3107416879795396, "bg": 4.908650474849041e-07}, {"x": 0.7525773195876289, "y": 0.07731958762886598, "ox": 0.7525773195876289, "oy": 0.07731958762886598, "term": "donald", "cat25k": 0, "ncat25k": 121, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 17, "s": 0.1134020618556701, "os": -0.33248081841432225, "bg": 2.4675918103821165e-06}, {"x": 0.4639175257731959, "y": 0.08247422680412371, "ox": 0.4639175257731959, "oy": 0.08247422680412371, "term": "kind", "cat25k": 0, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 12, "s": 0.21649484536082472, "os": -0.22378516624040917, "bg": 3.407274841280264e-07}, {"x": 0.8350515463917526, "y": 0.08762886597938144, "ox": 0.8350515463917526, "oy": 0.08762886597938144, "term": "restaurant", "cat25k": 0, "ncat25k": 157, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 22, "s": 0.06701030927835051, "os": -0.4411764705882353, "bg": 9.943600725319381e-07}, {"x": 0.4690721649484536, "y": 0.09278350515463918, "ox": 0.4690721649484536, "oy": 0.09278350515463918, "term": "15", "cat25k": 0, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 12, "s": 0.21649484536082472, "os": -0.22378516624040917, "bg": 0.0}, {"x": 0.4742268041237113, "y": 0.0979381443298969, "ox": 0.4742268041237113, "oy": 0.0979381443298969, "term": "st.", "cat25k": 0, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 12, "s": 0.21649484536082472, "os": -0.22378516624040917, "bg": 0.0}, {"x": 0.3917525773195876, "y": 0.10309278350515463, "ox": 0.3917525773195876, "oy": 0.10309278350515463, "term": "vergewaltigung", "cat25k": 0, "ncat25k": 78, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 11, "s": 0.2731958762886598, "os": -0.20204603580562658, "bg": 0.0012786237359060791}, {"x": 0.4793814432989691, "y": 0.10824742268041238, "ox": 0.4793814432989691, "oy": 0.10824742268041238, "term": "fr\u00fchst\u00fcck", "cat25k": 0, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 12, "s": 0.21649484536082472, "os": -0.22378516624040917, "bg": 0.0}, {"x": 0.4845360824742268, "y": 0.1134020618556701, "ox": 0.4845360824742268, "oy": 0.1134020618556701, "term": "trennung", "cat25k": 0, "ncat25k": 85, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 12, "s": 0.21649484536082472, "os": -0.22378516624040917, "bg": 0.0013947811937002382}, {"x": 0.5824742268041238, "y": 0.11855670103092783, "ox": 0.5824742268041238, "oy": 0.11855670103092783, "term": "sebastian", "cat25k": 0, "ncat25k": 93, "neut25k": 0, "neut": 0, "extra25k": 0, "extra": 0, "cat": 0, "ncat": 13, "s": 0.19072164948453607, "os": -0.24552429667519182, "bg": 5.59024253267228e-06}], "docs": {"categories": ["least reads", "most reads"], "labels": [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], "texts": ["Carfentanil : \u201e serial killer \u201c \u00d6sterreich aufgetaucht", "Bl\u00fcmel , Kneissl & Co. : Fixstarter", "Bank ausgeruht : Pensionist Strafe zahlen", "Fahnenskandal Mailand : Austria zeigt Flagge", "Matthias Reim spricht Absturz & Comeback", "Tod Vater : Tochter bekommt jedes Blumen", "YouTube : Schwere Probleme verst\u00f6renden Kindervideos", "Manspreading : # Womanspreading", "27-J\u00e4hriger betagte Nachbarin vergewaltigt", "Meghan Markles Verlobungs-Outfit : Details", "Regisseur Michael Haneke kritisiert Fl\u00fcchtlingspolitik", "Trump sorgt \" Pocahontas\"-Sager Eklat", "TV-Interview Prinz Harry & Meghan Markle", "Foodwatch vergibt \" Goldenen Windbeutel \" Alete-Kinderkekse", "Titanic-Regisseur : Jack sterben", "\u00d6VP FP\u00d6 dementieren geplante Kassenreduktion", "Glamour-Auftritt Charlene & Albert Rugby Gala", "Strengere Regeln Sch\u00fcler , Eltern \u2013 Lehrer", "Wintereinbruch naht : Schnee Osten", "\" gerettet \" : Andre Agassi Steffi Graf & Familie", "U4-St\u00f6rung legt Wiener Fr\u00fchverkehr lahm", "Schr\u00f6cksnadel Werdenigg : Aussprache", "\u00d6VP Studiengeb\u00fchren , FP\u00d6 Verhandlungen \" flexibel \"", "Pammesberger 2017 : Karikaturen KURIER", "Di\u00f6zese kontert Haimbuchners Bibel-Attacke", "Australischer Fernsehstar rechtfertigt Sexismus Asperger-Syndrom", "\u00d6VP FP\u00d6 alten Noten", "O\u00d6 : Drogendealer agierten Asylquartier", "Bildungsexperte Salcher : \" Lehrer Leistung bezahlen \"", "Britische Urlauberin filmte Australien Krokodil-Angriff", "Boris Becker : Pleite \" Missverst\u00e4ndnis \"", "Kurier TV-News : Wahlkampf-Attacken N\u00d6", "Harry & Meghan Markle : Details Hochzeit", "Direktorensprecherin Isabella Zins : AHS-Aufnahme neu geregelt", "Weichenstellung JVP : 23-J\u00e4hrige Generalsekret\u00e4rin", "Ehemalige Obdachlose : \" Gruft Familie \"", "Meghan Markle : Verlobungsring Dianas Brosche", "Ermittlungen zahlreicher sexueller \u00dcbergriffe kleinem Ort", "Koalitionsverhandler Konsens Krankenkassen-Fusion", "Glyphosat : Merkel wirft Landwirtschaftsminister Versto\u00df Gesch\u00e4ftsordnung", "78-Millionen-Pleite Textilreinigung Wozabal : Sanierung gescheitert", "Steve Aoki : verr\u00fcckte Luxusleben Star-DJs", "\" Jamaika \" geplatzt : Umfrage profitiert", "YouTube-Idole begeistern Jugend", "Scharfe Kritik Wien t\u00fcrkis-blauen Bildungspl\u00e4nen", "Kates Auftritt Museum : schnell Haare stylen", "Hauptversammlung : Standortbestimmung Rapid", "Naddel jobbt Gl\u00fchweinstand : Gef\u00e4hrdet neuer Job Gesundheit ?", "Koalition : Bildungspapier Pflichten Noten", "Hammerschmid Bildungspaket : \" Gef\u00e4hrlicher Populismus \"", "gef\u00e4hrlich Social Media", "Alice Schwarzer : Periode R\u00fcckschlags Frauen", "ANB", "Skip\u00e4sse Wintersport-Hochburgen massiv teurer", "Missbrauchsvorw\u00fcrfe US-Wellnesskette", "Schule Neuzeit ankommen", "\" Islamistisch motivierter Antisemitismus Gefahr Europa \"", "Koalition Konsens Krankenkassen-Fusion", "H\u00f6chste Vulkan-Warnstufe : 550 \u00f6sterreichische Touristen Bali", "Kritik Prinz Harry : \" verzogener Rotzl\u00f6ffel \"", "Missbrauchsverdacht : Lehrer Schwechat Haft genommen", "Augsburg-Boss : \" Leipzig Lizenz \"", "Google steigt Wiener IT-Firma", "RAF-Terroristin bittet Schleyer-Familie Verzeihung", "Frau t\u00e4uscht Tod , Fake-Liebhaber entkommen", "Angelina Jolie : fordert Geld Brad Pitt", "Alexander Newley , Sohn Joan Collins : \" Vater P\u00e4dophiler \"", "31 alte Frau Wien erstochen - Mann Ausland vermutet", "Seidenstra\u00dfe : chinesischer Keil Europa", "Glyphosat Verl\u00e4ngerung", "Bloggerin Anstiftung Magersucht angezeigt", "Suche U-Boot : Brand Wasser Schnorchel", "Python erw\u00fcrgte thail\u00e4ndischen Besitzer", "Lehrer Gymnasium Schwechat suspendiert", "Geschenk : Nicole Kidman bekommt Traumhaus 40 Mio. Dollar", "Ringen : Iraner verlieren , Duell Israeli vermeiden", "VIDEO : Basejumper springen Berg Flugzeug", "\" Vulkanausbr\u00fcche normal \"", "Regierungsbildung : SPD CDU bringen Stellung", "Missbrauchsvorw\u00fcrfe : F\u00e4lle Tiroler Hotline eingegangen", "Marihuana-Adventkalender findet Kanada rei\u00dfenden Absatz", "Vienna : OGH best\u00e4tigt Zwangsabstieg 2 . Landesliga", "Harry & Meghan Markle : offizielle Verlobungsfotos", "Deutscher B\u00fcrgermeister Messerangriff schwer verletzt", "Don Travel l\u00f6st Henry Bordk\u00fcche \u00d6BB-Z\u00fcge", "Meghan Markle Portr\u00e4t - TV-Sternchen Prinzessin", "Mordalarm Wien : 31 alte Frau erstochen", "Protest : Gesichtsscanner Apotheke   abgedreht", "Kurier TV-News : Krankenhaus Nord untersucht", "Aktivisten \" Washington Post \" Falle locken", "Missbrauchsvorw\u00fcrfe : F\u00e4lle Tiroler Hotline eingangen", "N\u00d6 : Bei\u00dfender Geruch Klasse", "\" Explosiver \" Mieter Groll Wohnung Luft gesprengt", "Willow Smith : \" schrecklich , aufzuwachsen \"", "Chinesen investieren 3 Mrd. Euro Osteuropa", "Gro\u00dfbritannien Vorreiter : Viagra k\u00fcnftig rezeptfrei erh\u00e4ltlich", "\u00d6BB-Containerzug China unterwegs", "Verkehrsunfall M\u00fchlviertel lie\u00df Autoschieber-Bande auffliegen", "Glyphosat-Verl\u00e4ngerung : SPD wirft CDU Vertrauensbruch", "Direkte G\u00fcterzug-Verbindung Italien China eingeweiht", "Gault et Millau traut Moskau", "Royaler Dresscode : Kate Middleton tragen", "\" Suits \" : Markles Hochzeit", "Chinesen bauen Autobahnen Serbien", "Ugly Sweater-WM : h\u00e4sslichsten Weihnachts-Look ?", "Auslieferung : Mutma\u00dflicher Sechsfach-M\u00f6rder Flugangst", "Meghan Markle : Lottogewinn ver\u00e4nderte Leben", "\u00d6fter dicke Luft Graz EU erlaubt", "Dominante Grazer nehmen Admira auseinander", "simple Strategie strahlende Model-Haut", "Kunsthistorisches Museum : Ausstellungen 2018", "USA : Oberstes Bundesgericht nimmt Klagen Waffengesetzen", "Omi Liebe sucht", "Missbrauchsvorw\u00fcrfe : Tiroler Skiverband durchsuchte Heim-Protokolle", "Serienr\u00e4uber schlugen mindestens zw\u00f6lf Mal Wien N\u00d6", "Toter Saunagast Welser Welldorado entdeckt", "Kolumne Ansto\u00df : Allerheiligste", "Bundesliga : Videobeweis Schlager Rapid-Salzburg", "Bestverdiener Nationalrat", "zahlt Einbau Gegensprechanlage ?", "  66 Bootsfl\u00fcchtlinge Schwarzen Meer aufgegriffen", "Schlecker-Bankrott : Haftstrafen fr\u00fchere Junior-Chefs Meike Lars", "WM-Qualifikation : H\u00e4rtetest Mallorca \u00d6sterreichs Damen", "Nachrichtenagentur : Nordkorea feuerte erneut Rakete", "Kurier TV-News : Wien bleibt", "Ungarns Regierung k\u00e4mpft Buch Soros", "Bitcoin knackt 10.000-Dollar-Marke", "Basketball : Debakel \u00d6sterreich Deutschland", "Nationalbank : 35 Tonnen Gold Wien", "\" Horror-Hans \" lebte Wochen Wald", "Sozialpartner Dinosaurier", "\"   typischer Gr\u00fcner \"", "Monat Koalitionsverhandlungen : bisherigen Ergebnisse", "Sozialunternehmen : Spardiktat trifft Behinderte", "Trump bangt Zustimmung Steuerreform", "H\u00e4lfte Drogenumsatzes Darknet EU", "Olympia : Eurosport Winterspielen Wege", "Miss Universe S\u00fcdafrika", "Herbe Klatsche \u00d6FB-Damen Spanien", "Suche U-Boot : Wasser Schnorchel verursachte Brand", "Hurts Wien : Wuchtige B\u00e4sse spa\u00dfigen Tanz-Sound", "Sicherheitsnetz Pensionskassen gefordert", "Drohnen-Sicherheitspaket pr\u00e4sentiert", "Fu\u00dfball , deutsche Bundesliga : K\u00f6ln-Vize Schumacher best\u00e4tigt : St\u00f6ger bleibt vorerst", "Heynckes : Saisonende endg\u00fcltig Schluss", "Tote Explosion Geb\u00e4ude Vorort Aviv", "Jugendliche Gefl\u00fcchtete : Bewegende musikalische Begegnung Geschichte", "plus 2,33 Prozent   Gro\u00dfteil Beamten", "Buwog-Prozess : Schwurgerichtssaal Wiener Landesgericht modernisiert", "Brexit : Briten EU-Kommission Zahlung geeinigt", "BGL : Gewalt Arbeitsplatz - T\u00e4ter meist Kollegen", "OMV-Chef w\u00fcnscht Hilfe Politik Russland-Deal", "Boris Becker : Pleite \u201e Missverst\u00e4ndnis \u201c", "Trump : letzte Verteidiger Roy Moore", "\" Moslem-Mama \" : FP\u00d6-Mann iranische Wurzeln", "Ski alpin : Anna Veith Comeback : \" Brenne aufs Rennfahren \"", "\u00d6SV : Sportlerin schweren Vorw\u00fcrfen", "Kelly Clarkson : Sexismus gew\u00f6hnt", "Kurier TV-News : Baustelle Bildung", "Austria vertraut letzten Aufgebot", "Identit\u00e4ren-Demo Paris : Festgenommene gro\u00dfteils Linksextreme", "Youth Start European Entrepreneurship Award : Stockerlpl\u00e4tze heimische \u00dcbungsfirmen", "Bio-Backzutaten SPAR Natur*pur - schmeckst Natur pur !", "Andr\u00e9 Heller holt Gandhi Tirol", "Postlerin Geisterfahrerin Rettungsgasse unterwegs", "LIVE : Spielstand Sturm - Admira", "Tormannlegende Jaschin ziert offizielles WM-Plakat", "Alternatives Backen - vegan , laktosefrei , glutenfrei", "Winter : Jeans st\u00e4rker friert", "Kanzlerin Merkel strebt stabile Regierung", "Welt gesehen", "Papst Myanmar-Besuch : Franziskus trifft Aung San Suu Kyi", "O\u00d6 : Arbeiter Schwenkarm Seilbaggers erschlagen", "Investment !", "Ver\u00e4ndert : sehen 80er-Stars", "Postler Geisterfahrer Rettungsgasse unterwegs", "Charlene : Frisur & neues Gesicht Geburtstag", "Ski alpin : Verletzter Neureuther hofft Olympia-Chance", "Ermittler filzten Airbus-Firmensitz Paris", "Finanzinvestor fordert Fusionsgespr\u00e4che CA Immo/Immofinanz", "Charlene Wei\u00df Papst Franziskus", "Hammerschmied Bildungspaket : \" Gef\u00e4hrlicher Populismus \"", "tiefe Fall Pop-Prinzessin", "Bildungs-Defizite : Lesen hapert", "\" Sittenw\u00e4chter \" See Nieder\u00f6sterreich : Hauptverd\u00e4chtiger Haft", "Prinz Harry & Meghan Markle : Verlobung offiziell", "Deutsche Bahn P\u00fcnktlichkeitsziel 2017", "Patient Taxi heimgeschickt", "Emma Watson : heimlich getrennt", "Menschenh\u00e4ndlern Kriegstouristen", "Leberk\u00e4se-Produzent Gourmetfein : Luft , Wasser", "Heidi Strobl : Feigenkrapferln", "Neujahrskonzert d\u00fcrfte Mutis letztes", "Olympische Spiele : \u00d6sterreich Rot-Wei\u00df-Grau", "Fu\u00dfball , Bundesliga : n\u00e4chsten Leihgesch\u00e4fte Rapid", "Trump : 16,5 Millionen Dollar 5 Urlaub", "Bloggerin wei\u00df , Fehlk\u00e4ufe vermeidet", "Benetton holt Schock-Fotograf Oliviero Toscani Boot", "Olympiasiegerin best\u00e4tigt Missbrauch Team-Arzt", "Naddel rechnet Verona Pooth : \" eifers\u00fcchtig \"", "Hariri : \" Premierminister bleiben \"", "Bloggerin erkl\u00e4rt : Sex , jenseits Size Zero", "\" Adam sucht Eva \" abserviert : Blanco l\u00e4stert Christian", "Fitzgerald-R\u00fccktritt : Regierungskrise Irland beigelegt", "Apfel Perlen", "Donhauser l\u00f6st Do&Co \u00d6BB-Caterer", "Anstiftung Doppelmord N\u00d6 : 18 H\u00e4ftling", "Kurier TV-News : Umfrage - \u00d6sterreicher stehen Sozialpartnern", "britische Banken harten Brexit gewappnet ?", "  \" Ninja Warrior Austria \" Finale", "Wort", "Hariri Hisbollah kurze Leine nehmen", "Betrunkener findet T\u00fcr\u00f6ffner Stunden", "Pizza Weltkulturerbe : Millionen Unterschriften gesammelt", "Ohrwaschl : To make good Operette", "unterscheidet Diamanten Brillanten ?", "Papst traf Myanmar Oberbefehlshaber Armee", "B\u00fcrgermeister meldet Schlaganfall erstmals", "Antibiotika : 6 Fehler : Einnahme beachten", "Charlene : Zwillinge lernen Sprachen", "Prinz Philip : Ger\u00fcchte Aff\u00e4ren", "Aufgedeckt : arbeitet \" Baumafia \" \u00d6sterreich", "100 \" Tank \" Cartier : Panzer royalen Handgelenk", "Global Drug Survey : Wodka weinerlich , Rotwein m\u00fcde", "7.000 Euro Strafe Richter , junge Auszubildende bel\u00e4stigte", "Kritik Meghan Markle lauter", "500 Euro sparen Tausch Heizung", "\" Iss Schokolade \" : Depressionen wissen", "Schwarze L\u00e4nder t\u00fcrkis", "Snowboard : Gasser-Verzicht Start Big Air M\u00f6nchengladbach", "Modenschau Opfern S\u00e4ureangriffen Indien", "Glyphosat : EU-Staaten stimmen Zulassung", "Kosmetikerin verr\u00e4t Herzogin Kates Beauty-Tricks", "Start-ups veganen Produkten verwursten", "\" Times\"-Fachranking : heimische Unis Top-500", "Prozente Packerln", "Fu\u00dfball-Splitter : Hinteregger verl\u00e4ngert Augsburg 2021", "Influencer : Netz", "Werdenigg : \" Schr\u00f6cksnadel wissen \"", "Pfeiffer : Supermarktkassa Hollywoodstar", "\" Volkswille \"   \u2013   Spiel Feuer", "Florian Holzer : Top 5 : Lebzeltereien", "Bundespr\u00e4sidentenwahl : FP\u00d6 Verfassungsrichter Schnizer einigten Vergleich", "Melanias Modewoche : Luxus-M\u00e4ntel g\u00fcnstige Blusen", "\u00c4therische \u00d6le : Frau erlitt Verbrennungen", "gr\u00f6\u00dften Baustellen Bundesheers", "M\u00e4\u00dfiger Kaffeekonsum Vor- Nachteile", "Familie Social-Media : Millionen Klicks Mama-Bloggerinnen", "Manspreading : Madrid breitbeinige Sitzer", "Mutma\u00dflicher Sechsfachm\u00f6rder Aslan G. : OGH entscheiden", "New York : \" M\u00e4nner , schlie\u00dft Beine ! \"", "Sissi - Musical - 22 . J\u00e4nner 2018", "Heurige Sommersaison brachte h\u00f6chste N\u00e4chtigungszahl 1992", "Eishockey : Raffl-Tor Overtime-Niederlage Flyers", "Fu\u00dfball : Zeuge FIFA-Prozess : Schmiergelder WM-Vergabe 2022", "Boris Becker : Kritik Ex-Trainer", "M\u00e4nner bel\u00e4stigt : 41-J\u00e4hrige verurteilt", "Veronika Pachala : Carrots for Claire : Gesund backen Liebe", "Paaradox : Berlin Nacht", "Ex- Innenminister Karl Schl\u00f6gl : Schwarz-Blau fix", "\" Zivilisation zerbricht \"", "Studentin Wiener Park niedergestochen : 16-J\u00e4hrige Gericht", "Radarwarner : gewieften Hightech-Tricks \u2005 Polizei", "Shopping-Tourismus : Gulasch , Friseur Fettabsaugung", "Isabella Zins Sprecherin AHS-Direktoren", "Heidi Strobl : Topfenstollen", "Wien : Stromausfall mehreren Bezirken", "Katie Price : knallhart vermarktet Kinder", "\" Akademische Nachhilfe \" g \u2018 standene B\u00fcrgermeister", "England : Arnautovic \u00fcberzeugt Remis", "Sexismus : Renee Rabinowitz verklagt israelische Airline El Al - gewinnt", "O. J. Simpson : Luxusleben Haftentlassung", "RunNa : L\u00e4ufst kotzt ?", "Naddel abd el Farrag : Absturz Mallorca", "Ans Meer : Sanit\u00e4ter erf\u00fcllen Sterbender letzten Wunsch", "vegane Schuhe ?", "\" Raucher L\u00e4nder , \u00d6sterreich \"", "Trainer Spielern Pause , Krebs", "notiert : News Welt Sports", "Fr\u00fchst\u00fcckshochburg", "Fu\u00dfball , Legion\u00e4rs-Check : Tore Burgstaller Gregoritsch", "Veronica Ferres : geheimes Luxusleben L.A.", "Missbrauchsskandal : Schatten Vergangenheit", "Britische Urlauberin filmte Australien Krokodil-Angriff", "Vegan : Gesunde Revolution Werbe-Schm\u00e4h ?", "Heidi Strobl : Griesskn\u00f6del karamellisierter Birne", "Kabarett , Humor , Satire", "VBS Floridsdorf : \u00dcbungsfirmen , Bewegungs\u00fcbungen Balkons-Szenen \u2026", "Weihnachten Optimismus Handel Kunden", "Influencerin rechnet Di\u00e4t-Drink-Hersteller", "trockenen Schienbeinen hilft -", "Streit Sieg Pr\u00e4sidentenwahl Honduras", "  Kinder-Online-TV", "Japan : Leichen mutma\u00dflicher Nordkoreaner angeschwemmt", "Internationaler Fu\u00dfball : Valencia trotzt Barca Remis", "Tiffany Setting : Verlobungsring , Frau \" \"", "Sensoren Kleidung messen Puls Blutdruck", "Angelina Jolie Strich Landschaft", "Rapid-Trainer Goran Djuricin : \" Volksschule \"", "# metoo-Debatte : Lena Dunham verheddert", "Autismus : National Autistic Society zeigt , Autisten Welt wahrnehmen", "Rezept letzte Folge Game of Thrones : Sansas Zitronen-K\u00fcchlein nachbacken", "Irische Vize-Ministerpr\u00e4sidentin tritt", "Regierungskrise Irland beigelegt", "\u00dcberLeben : \" Oje \"", "Schuldenberg bremst SP\u00d6 Oppositionsstart", "3D-Zebrastreifen \u00d6sterreichs Linz", "Regenw\u00fcrmern Mars gefallen : mars\u00e4hnlicher Erde pflanzen fort", "Erich Foglar trotzt Kritik \u00d6GB nochmals antreten", "Fu\u00dfball-Splitter : Mario G\u00f6tze f\u00e4llt erneut", "71-J\u00e4hrige starb Brand Wien-Leopoldstadt", "Darren Aronofsky : Tyrann Musen", "Robyn Stein DeLuca : Psychologin erkl\u00e4rt PMS Mythos", "\" Araber verstehen Europa \"", "\u00d6BB WK : \u00d6sterreich \" Seidenstra\u00dfe \" anbinden", "Fu\u00dfball-Splitter : Reals Marcelo Steuern nachzahlen", "Gericht Kairo verurteilte 14 homosexuelle M\u00e4nner", "Nummer 4 spielt", "Kaschmir-Pullover F\u00e4lschung", "Leitungswasser schlechter Haut f\u00fchren", "k\u00fcnstlicher S\u00fc\u00dfstoff K\u00f6rper anrichtet", "Todesfahrt Friedhof", "Salz & Pfeffer : The Birdyard", "Spittelberg-Alternativen : Wiens Weihnachtsm\u00e4rkte", "Sophie Mayanne : Fotografin zeigt Sch\u00f6nheit Narben", "\" Blutbad \" Wanderung norwegischer Rentierherden", "Tabuthema vernachl\u00e4ssigte Muskelgruppe : Beckenboden Probleme", "Sonntag Winter", "Magerwahn Social Media", "Missbrauchsvorw\u00fcrfe \u00d6SV : Schatten Vergangenheit", "\" Kinder verr\u00fcckt\":Angelina Jolies fragw\u00fcrdige Erziehung", "Magazin \" GELD \"", "Erk\u00e4ltung : Hausmittel Blick", "Zucker : 3 nat\u00fcrliche S\u00fc\u00dfungsmittel", "Promi-M\u00e4nner hinaus", "Don Pasquale", "J\u00fcngste Mandatarin Claudia Plakolm studiert fertig , \u00e4lteste Irmgard Griss \" Gouvernante \"", "Tschechien : Vergessene Nazi-Opfer", "Artenvielfalt wichtiger angenommen", "\" ... manchmal weint \" , 3", "Brexit : \u00c4rger k\u00fcnftige EU-Au\u00dfengrenze nimmt", "WG demente gegr\u00fcndet", "USA : Exekution Schwerkranken verschoben", "O\u00d6 Magazin", "Wahl : Einkaufen Nieder\u00f6sterreich", "Formel 1 : Niki Lauda verk\u00fcndete Abschied RTL-Experte", "Weihnachtsgeschenk Ex-Drogerie-K\u00f6nig , Haftstrafen Schleckers Kinder", "800.000-Euro-Show", "Impressum KURIER.at", "Onkologe Univ.-Prof . Heinz Ludwig : 5-L-Strategie l\u00e4nger lebt", "\" Sirkkaleip\u00e4 \" : Finnen backen Insektenbrot", "Vorarlberg Gebietskrankenkassen beibehalten", "\" wissen , scheinen naiv , Pflichten \"", "Uni-Exzellenz fehlt", "Jugendstil Kroatien", "Kurier TV-News : \u00d6SV Vorw\u00fcrfen Druck", "Titanic : Formel zeigt , Jack \u00fcberleben", "Heimskandal - Brigitte Wanker : Landesverr\u00e4terin", "Design Schenken", "Liste Pilz bem\u00fcht Cannabis-Freigabe medizinische Zwecke", "58 Kilo Drogen : Schmugglerring zerschlagen", "Caf\u00e9 verbietet G\u00e4sten Jogginghosen", "Shell Spar \u00d6sterreich getrennte Wege", "Arbeiterkammer : Henry Zug Strafe ausgefasst", "Fu\u00dfball , Bundesliga : Salzburg schl\u00e4gt Rapid rassigen Topspiel", "Essst\u00f6rungen : propagieren sch\u00e4dliches K\u00f6rperbild", "Panzer Vorgarten : Brite Streit deutschen Nachbarn", "7 Tipps , frieren", "Suizid Fl\u00fcchtlingsbub : Warnungen Diakonie", "Nachtarbeit , Jetlag : Unregelm\u00e4\u00dfiger Lebenswandel beg\u00fcnstigt Diabetes", "Mann stahl Russland 200 Pelzm\u00e4ntel Privatwohnung", "\" HC \"", "Szenen", "34 Kilo Drogen Wiener Bunkerwohnung", "Boris Becker : missverstandene Held", "Wien : Mann w\u00fcrgte achtj\u00e4hrigen Klassenkameraden Sohn", "Missbrauchs-Debatte : AK-Studie : Sexuelle Bel\u00e4stigung Junge allt\u00e4glich", "Ski alpin : \u00d6SV reagiert Vorw\u00fcrfe Ex-Skil\u00e4uferin Werdenigg", "Wein Wild", "Penis-Sitz : Mexiko City setzt Kampagne sexuelle Bel\u00e4stigung", ", Belegschaft altert", "Jennifer Garner : cool simpler Abendlook", "Fu\u00dfball-Splitter : Buffon Italiens Bester", "Kindergarten-Chaos", "Ohrwaschl : Gurten Flug", "Heidi Strobl : Mandelspritzgeb\u00e4ck", "RAFFAEL", "Raus Tretm\u00fchle , rein Abenteuer", "Jeans niemals waschen", "Explosion 8000 km h\u00f6ren", "Ex-Skil\u00e4uferin spricht sexuellem Missbrauch", "K\u00fcrzung Mindestsicherung Gezerre", "schmutzigsten Ecken Flugzeug", "FP\u00d6 : Vorzeige-Frauen abseits M\u00e4delschaften gesucht", "\" Solidarit\u00e4tsbeitrag \" Politiker-Geh\u00e4ltern Neustart Gr\u00fcnen", "EU-Budget zahlt , empf\u00e4ngt \u2013 \" Fragen \" \"", "Pikante Millionen-Pleite Anlagenbauers", "Punsch out : trinken hei\u00dfen Lillet", "Kontakt", "Sesam , Vanille , Quinoa : Lebensmittel Natur erkannt ?", "Mantel-Fehler , ( fast ) Frau passiert", "Irakische Armee entdeckte yezidisches Massengrab", "\u2005 \" Fat but fit \" Mythos : \" gesundes \" \u00dcbergewicht", "Ammersin er\u00f6ffnet Mikrobrauerei Muttermilch Brewery Wien", "Formel 1 : Hamilton \u00fcberl\u00e4sst Bottas Sieg Abu Dhabi", "Porsche-Stretchlimousine f\u00e4hrt Wien", "chaos De LUXE : Big Bang", "Frauen Heer : 582", "Schr\u00f6cksnadel Causa Werdenigg : \" Klage gedroht \"", "Besitzer lie\u00df Tiere : Reptilien verendet", "Deutscher Derby-Wahnsinn : Schalke 0:4 4:4", "Wiener kaufen heuer Millionen Geschenke", "Verlobungsringe 100 ver\u00e4nderten", "Besondere Christkindlm\u00e4rkte \u00d6sterreich", "gesunder Lebensstil belohnt", "Lorbeer verdient", "Weihnachtsm\u00e4rkte : Schr\u00e4g kitschig", "Stadt Salzburg : Favoriten duellieren Stichwahl ums B\u00fcrgermeisteramt", "Hofer-W\u00e4hler Kaffeehaus erw\u00fcnscht : \" Bitte \"", "MakeApp : Massive Kritik App , Frauen \" abschminkt \"", "Jeans vorne Tasche", "Duo Surfopening-Besucher Drogen versorgen", "Mojtos Beta Film Einstieg Wiener MR Film", "Notsignale argentinischem U-Boot empfangen", "Hofburg brannte", "Bittere Pleite Haustechnik-Firma", "fabelhafte WELT : Vea Kaiser", "\u00d6VP FP\u00d6 : Zur\u00fcckrudern R\u00fcckbau Mindestsicherung Fl\u00fcchtlinge", ", Zucker verw\u00f6hnen", "Kim Kardashian \u00c4rger Leihmutter", "USA : Tabakkonzerne starten Werbekampagne Rauchen", "Einbruchsserie \u00d6sterreich gekl\u00e4rt : Wert Beute 2,7 Mio. Euro", "Robert Forster : Konzert Lesung Wien", "St\u00e4dte Feinschmecker 2017", "Hunde gingen 9000 Leine", "Mini-Sprachkurse : Mutter fast Pferd Hanf klingt", "Lebensversicherung : Vorsicht ! Versteckte Kosten dr\u00fccken Ertrag", "Erdogan : \" Gewalt Frauen inakzeptabel \"", "Simbabwe : Wei\u00dfe Farmer entsch\u00e4digt", "Barbara Becker spricht erstmals Ermakova-Aff\u00e4re", "Zuschauer beleidigt : ProSieben-Chef endg\u00fcltig", "OGH-Urteil : Richter versprach Amtsanw\u00e4rterin Orgasmusgarantie", "Fondssparen 50,- Euro monatlich lukrativ", "Burgenland : \u00d6VP bietet Doskozil Zusammenarbeit", "\" Borat\"-Erfinder Cohen Fans Strafe zahlen", "Erz\u00e4hlte Geschichte Museum Nieder\u00f6sterreich", "Russland-Ermittlungen : Trump-Wahlkampfleiter Manafort stellt US-Beh\u00f6rden", "Junge \u00d6VP : \u00fcbergab Vorsitz Schn\u00f6ll", "Aquazzura-Designer Edgardo Osorio Interview", "Angelina Jolie : Chirurgin neues Gesicht", "Geldnot : Retter Rettungsfall", "glamour\u00f6ser Abend Tom Ford Fleur de Mode", "bedeutet schlichtes Miteigentum ?", "Alarmstufe Rot Graz : Luft", "Tote Auffahrunfall Nordostautobahn Burgenland", "Vulkan Bali : 100.000 Flucht aufgerufen", "Einfach transparent \u2013 Wertpapierdepots", "T\u00f6dliche Sch\u00fcsse Graz : Tatfahrzeug sichergestellt", "Anlegertyp ?", "Fehlalarm : Suchaktion vermisster Person Bodensee", "Bitte weiterer Marketing-Gag", "Expansion : Vapiano wachsen", "Micaela Sch\u00e4fer erz\u00e4hlt Bel\u00e4stigung Steven Seagal", "P\u00e4dophilie : Youtube-Werbung Kinderbildern gestoppt", "\" Black Friday \" : Amerikaner kaufen 200.000 Waffen", "Kinohit Saison ORF", "Winter : Haut gepflegt", "Jugendliche Sex : \" oral , vaginal , anal \"", "Fl\u00fcchtlinge : Vorurteil Job-H\u00fcrde", "Musiker Symphoniker U-Bahn attackiert", "Uma Thurman bricht Schweigen Harvey Weinstein", "Ski alpin : Starke \u00d6SV-Abfahrer machten Auftakt Lust", "Steven Spielbergs Saurier tobten", "Stur Leben", "Klein fein Advent", "Super-G Lake Louise : \u00d6sterreicher Podest", "Meghan Markles Schwester l\u00e4stert Pippa", "Boris Becker : \" weder zahlungsunf\u00e4hig pleite \"", "Fliegen verbreiten Bakterien gedacht", "Angelina Jolie & Brad Pitt : Streit Weihnachten", "Nikon schlie\u00dft Smartphones Kamera-Fabrik China", "Ortstafeldieb Obersch\u00fctzen Beutezug", "Hillary Clinton bezeichnet Putin Manspreader", "Festgenommene Syrer frei", "Fl\u00fcchtlinge fast \u00fcberall   gleichgestellt", "Basketball : Routine Prestigeerfolg", "Pikante Millionen-Pleite Solar-Firma", "Salz & Pfeffer : Block House", "Serena Williams : New Orleans-Hochzeit Star-G\u00e4sten", "Birgit Schrowange zeigt Single-Leben ihren Mann", "Ohrwaschl Katastrophe f\u00fcrs B\u00f6rsel", "Schadenersatz Nachbars Schulden : Frist gilt ?", "Kleiderschrank : liegen , h\u00e4ngen ?", "Joan Collins trauert Schwester Jackie", "Fu\u00dfball : Last-Minute-Sieg Austria Wolfsberg", "Redaktion Print Bundesl\u00e4ndern", "FP\u00d6 N\u00d6 Vielfalt punkten", "Salz & Pfeffer : Merak", "Charlene vs. Caroline : Konkurrenten Nationalfeiertag", "Auswirkungen # metoo , Zusammenarbeit ?", "K\u00f6stinger : Direkte Demokratie behutsam ausbauen", "Meghan Markle : Prinz Harrys Freundin", "Fu\u00dfball-Splitter : Benevento setzte Rekord-Negativserie fort", "Zwillinge unterschiedlicher Hautfarbe Stars Instagram", "Caf\u00e9 Monic", "bereiten Chinakohl", "\" Kannibale Rotenburg \" Gef\u00e4ngnis", "Hirnforschung : intelligent n\u00e4chsten Verwandten", "Katalonien : Spanischer Generalstaatsanwalt erhebt Anklage Puigdemont Minister", "Dry Brushing sch\u00f6nerer Haut verhilft", "Silvester Hunde Stress", "Ungustln Showbusiness", "Nationalratswahl 2017 : Liveticker", "Sexualisierte Gewalt : K\u00fcnstlerin zerlegt vermeintliche Entschuldigungen", "Europa League : Austrias Hoffnung lebt - trotz Lehrstunde Mailand", "Treffpunkt Wien : \" Frauen komisch \"", "Tatort :", "\" Kraft Alters \" Belvedere : Lebenslust Herbst Lebens", "Explosion lief \" Puls 4 \"", "Kleiderschrank ausmistet", "Studienabbruch \u2013 ?", "Athina Onassis : Scheidung offiziell", "Rekordjagd treibt Bitcoin Richtung 10.000 Dollar", "Sicherheit , 's mal l\u00e4uft", "Streit Vincis 450-Millionen-Bild", "Washington bekommt Anti-Trump-Hotel", "Trumps Justizminister l\u00e4sst Clinton-Stiftung ermitteln", "besonderen Adventkalender", "Hakenkreuz Widerstand : England Nazi-Herrschaft", "Flake Rammstein : Letzte", "Wand Museum", "Jessas , Eierpecken !", "Klubbb3 : Florian Silbereisen Schlagerband Spa\u00df", "Fu\u00dfball : Sturm Last-Minute-Sieg LASK erneut Leader", "May EU-Handelsabkommen sprechen", "N\u00d6 : 28-J\u00e4hrige prallte Waldviertel Auto Baum", "wehrt frischluftfanatische Nachbarn ?", "versteckte Zuckerfallen umgeht", "importierte Einkaufswahn", "\u00d6sterreich Brauerei : MUTTERMILCH \u2013 VIENNA BREWERY", "W\u00e4nden Platz ausgeht", "6 goldene Regeln Geldanlage", "OECD rechnet Prozent Wirtschaftswachstum", "Operns\u00e4nger Dmitri Hvorostovsky gestorben", "Heuschrecken-Fonds Retter", "Handel : KURIER freizeit Weihnachtsextra", "\u00d6VP Ausgaben Wahlwerbung klar vorne", "moderne Hexe dr\u00fcckt Schulbank , bevor zaubert", "Boris Becker : beichtete Kindern Geld-Probleme", "Gogol Bordello : Eins Universum", "Baufirma zahlte Polizisten jahrelang Weihnachtsfeiern", "Victoria 's Secret Show 2017 : Kurven-Model Ashley Graham schummelt Photoshop", "Finale Casinos-Poker", "Onlineteam kurier.at", "Knalleffekt : Servus TV stellt Betrieb", "\u00d6ko-Test findet Bio Pestizide Wohlf\u00fchltees", "K\u00e4rnten : Bewerbung Christbaumverk\u00e4uferin endete Erpressung", "215.000 gemeldete Sexualverbrechen 2015 EU", "Nina Proll : Schauspielerinnen \" schwerer \"", "\" Unendliche Geschichte\"-Stars", "Pakistanischer Justizminister tritt Islamisten-Protesten", "Onassis-Scheidung : Doda achtj\u00e4hrige Aff\u00e4re belgischer Escort-Dame ?", "Deutsche Weihnachtsm\u00e4rkte erneut potenzielles Terror-Ziel", "World \u2019s Best Restaurants : Steirereck El Celler de Can Roca ausgezeichnet", "Soros-Uni Ungarn : Parlament beschloss umstrittenes Hochschulgesetz", "Beste \u00f6sterreichischen Alpen New York City", "Patientenbefragung zeigt : Frauen leiden \u00f6fter st\u00e4rker Schmerzen", "Vitamin D Kraftquelle finsteren Jahreszeit", "Naddel ed Farrag : \" Lebe 400 Euro Monat \"", "Missbrauchsvorw\u00fcrfe : \u00d6SV stellt Werdenigg Ultimatum", "Gregor Seberg anderes", "Hoppala : Bella Hadids Nippelblitzer Victoria 's Secret-Show", "Fl\u00fcchtet Super-Sektionschefin ?", "Versenkte Bahn Thema", "Opel schenkt \u00d6VP-Abgeordneter Auto : erlaubt ?", "Feuerwehr Swimmingpool anzapfen", "Flugzeug : Abheben Licht ausgeht", "Norweger : M\u00e4nnerschuh , Wiener lieben", "Bodyblog : Weihnachtskekse Zucker", "Britische Studie zeigt , Sexvorlieben Jugendlichen ver\u00e4ndert", "Stefanie H\u00f6hl schaut Babys K\u00f6pfe erforscht Entwicklung", "Supermacht Out : Trump man\u00f6vriert USA weltpolitisch Eck", "\" Verfahren dauern \"", "5:2 Skin Diet : Geheimnis sch\u00f6nerer Haut", "Haut Haare : sch\u00f6n Apfelessig", "Millionenpleite Personalleasingfirma", "Trzesniewski : Festtagsbr\u00f6tchen", "Heidi Strobl : Indischer Dal Erdn\u00fcssen Sternanis", "Trinken sch\u00f6n", "Wirbel Kopftuch-Sager Bundespr\u00e4sident Van Bellen", "vollst\u00e4ndige Krebs-Liste : 116 Faktoren , Risiko erh\u00f6hen", "Kuriose Erfindung : Kosmetik speziell Raucher", "Winterhaut-Probleme , Vaseline l\u00f6sen", "Fall Lopatka : \" Arzt treibt Suizid \"", "Abtr\u00fcnnige Abtr\u00fcnnige Ostukraine", "\u00dcberschwemmungen Griechenland : Zahl Toten 23 gestiegen", "Ski alpin : Killington-Slalom - Schild klarem Shiffrin-Sieg", "Biathlon : Weltcupsieg Lisa Hauser , Eder Single-Mixed-Staffel", "\" Verbrennungsmotor gelaufen , paar \"", "Lassen Geld einfach Seite liegen", "Mord J\u00e4gerstra\u00dfe : Tatversion br\u00f6ckelt", "Gib : Fehler Job kosten", "Bawag Rekordkurs   Einkaufstour", "Polizeisch\u00fcler bekommen 1.12 . Geld", "Hochzeitskleid Herzogin Kate Kopie ?", "Meghan Markle : Hetzjagd Harrys Freundin", "Emirate warnen geflohenen IS-Terroristen Raqqa", "Ulrich Seidl Interview : \" Film missgl\u00fcckt \"", "\u00dcbersiedeln einpacken ?", "Wiener Gr\u00fcne : R\u00fccktrittsantrag zur\u00fcckgezogen", "Koalition ? SPD Gespr\u00e4chen bereit", "Tote Verkehrsunf\u00e4llen Nacht Samstag", "Fertigstellung neuem Berliner Flughafen wackelt", "Bauwerke Bedeutung", "H\u00f6here Strafen : Wien versch\u00e4rft Tierhaltegesetz", "15-j\u00e4hrige R\u00e4delsf\u00fchrerin Mal zugeschlagen", "Feinstaub : Autofreier Graz angedacht", "T\u00fcrkischer Sender Stimmung \u00d6sterreich", "Mediziner warnen Welt-Diabetes-Tag : \" Diabetes bagatellisiert \"", "Tsipras : Griechenland wettbewerbsf\u00e4hig", "7 Fashion-Hacks , Frau kennen", "Zw\u00f6lf Naturschaupl\u00e4tze , Staunen versetzen", "Fachkr\u00e4fte   Welt", "EuGH-Anwalt : EU-weite Sammelklage Facebook unm\u00f6glich", "Weihnachtsm\u00e4rchen Marokko", "Kerns Job-Bonus : roter AMS-Chef", "Heidi Strobl : Kaffee Granita Mandeln", "Iran droht Europa gr\u00f6\u00dferer Raketen-Reichweite", "Positively Glittered : Glitzer Body-Shaming", "Stimme , Freude", "VKI-Test : Drittel Lebensmittel Fett", "Instalove Hund Katz", "Paradise Papers : legal ? Skandal", "Rostock Sommer 2018 Linz", "Verr\u00fccktes 3:3 Roma : Austria erk\u00e4mpft Remis Rom", "RHI Mondi : Lehre \u00e0 la mexicana", "Hafen-Viertel hippen Location", "Russland Milit\u00e4rpr\u00e4senz Syrien Jahresende zur\u00fcckfahren", "Fu\u00dfball , deutsche Bundesliga : Klarer 3:0-Sieg HSV Hoffenheim - K\u00f6ln sieglos - 0:2-Heimniederlage Hertha", "Tagebuch , Wolfgang Winheim : Spieler 13 Nationen Schlager H\u00fctteldorf", "B\u00e4ckerei Par\u00e9mi setzt franz\u00f6sische Backkunst", "Thun-Hohenstein \u00f6sterreichische Kuratorin Kunstbiennale 2019", "Robbie Tripp : Mann schreibt Liebesbrief \" kurvige \" Freundin", "ORF : Krach \" ZiB \" \" Report \" Rede", "leise kriselt Schnee", "\u00dcberraschend : O.J Simpson eigentlich Terminator", "\" t\u00fcrkischen Community herrscht Panik \"", "Designer Azzedine Ala\u00efa tot", "\" Spiel \u2019 , ( Is ) Sam \" : Besuch Casablancas legend\u00e4rer Film-Bar", "Julia Roberts & Co. : Stars , Filmset schikaniert", "Di\u00e4t-Produkte figurfreundlich", "Hauptberufliche B\u00fcrgermeister bleiben Minderheit", "Handwerklich begabt : interessiert   ?", "Gem\u00fctliche Zimmer , ungem\u00fctliche Auflagen", "\" lieben Fernsehen ! \" : pl\u00f6tzlich Welt bunt", "trinkfest Politiker ?", "Millionen-Pleite Baufirma", "Verschollenes U-Boot : Argentiniens Pr\u00e4sident Aufkl\u00e4rung", "rohes Eigelb Kaffee mischen", "Shiloh & Zahara : Lust Angelina Jolies \u00dcber-Mutter-Show ?", "Skandal Karl Lagerfeld : Fl\u00fcchtlinge beschimpft", "Stermann-Auftritt Kern : ORF r\u00e4umt Fehler", "Jahreshoroskop 2017 : Stier", "Studie : Morgen\u00fcbelkeit f\u00fcrs Baby", "Fu\u00dfball : Sp\u00e4tes Gl\u00fcck Premierl-League-Leader ManCity Arsenal England", "Billboard Music Awards 2017 : Celine Dion : Outfit sorgte Gespr\u00e4chsstoff", "Kreuzbandriss : Saison-Aus Felix Neureuther", "Abgabenquote : \u00d6sterreichs Weg Slim-fit-Staat", "Herzogin Kate : Onkel Gary Goldsmith droht Gef\u00e4ngnis", "\" Haptic-Touch T\u00fcr\u00f6ffner \"", "Geplante Terrorattacke : IS-Mitglieder \u00d6sterreich T\u00fcrkei festgenommen", "Medizin-Mythen : Hilft Pelargonien-Extrakt Erk\u00e4ltungen ?", "sitzen : Tools B\u00fcro helfen", "Bambi 2017 : Outfits Stars", "Historische Wertpapiere Hammer", "Nieder\u00f6sterreicher Angst b\u00f6sem Wolf", "Kontakt Redaktionen", "Ausbildung , Zukunft", "U6 , Wiens grausige U-Bahn : W\u00fcrdigung", "Mordverdacht D\u00e4nemark : U-Boot-Bauer bleibt freiwillig Untersuchungshaft", "Michelle Pfeiffer : Wieso Auszeit Hollywood", "EU-Arzneimittelagentur : Wien ausgeschieden", "\" geniert derzeit , Muslim \"", "Naddels intimes Gest\u00e4ndnis Dieter Bohlen", "Regierung erwartet sozialpolitisches Minenfeld", "Satirepreis \" Goldenes Brett vorm Kopf \" 2017 \" K\u00f6nig Deutschland \" Peter Fitzek", "Missbrauch , psychische St\u00f6rungen , Doping erkannte Verletzungen - dunkle Seite Sports", "Salz & Pfeffer : Allerley", "Lionel Messi verl\u00e4ngert FC Barcelona", "Islamkinderg\u00e4rten : Aslan Pr\u00fcfbericht frei", "Schwerster Anschlag \u00c4gypten", "Badeverbot angeblich \" Tisch \"", "Caritas-Chef Landau : \" Politik scheint Steuerfl\u00fcchtlinge billigen \"", "Neuer KV : Handel flacht Gehaltskurve", "\" Sittenw\u00e4chter \" positiven Asylbescheid", "Italiener X-Beinen", ", , Isl\u00e4nder", "Forschung : f\u00fchrt Sex Herzstillstand ?", "Heinz Fischer : \" Antennen nutzen \"", "Gucci Memes : beste Uhren-Werbung Zeiten", "Herzogin Kate empfiehlt Michelle Obama Botox-Gel", "Fotoserie thematisiert Vergewaltigungskultur", "Sport : Stunde pro Woche beugt Depressionen", "Buwog : Ex-RLB-Chef Scharinger laut Gutachten prozessf\u00e4hig", "Millionen-Pleite Reiseb\u00fcro-Gruppe : Brisante Ermittlungen abgeschlossen", "Parfum B\u00fcro : Expertin Tipps , angebracht", "Jahreshoroskop 2017 : Jungfrau", "Sieg Langl\u00e4ufer Kl\u00e6bo", "Hochzeitskleid-Trend 2016 : Sieht teuer ,", "K\u00e4rnten : Kriminelle Jugendbande festgenommen", "Capitals-St\u00fcrmer Rotter Tore Zukunft", "Jahreshoroskop 2017 : Steinbock", "Doskozil : Milliarden-Einsparung ?", "Formel-1-Saison spannend ?", "Wiener Gr\u00fcne debattieren Zukunft Landespartei", "Rekordpreis : teuerste Diamant Welt", "Bel\u00e4stigungsvorw\u00fcrfe : US-Demokrat Posten", "\" Schwarz-roter Postenschacher Mottenkiste \"", "AGB", "Herzogin Kate Sturmfrisur", "28 . Juli 1914 : Sommertag Anfang", "EU-Agenturen : Tetsch \u2019 n   Wien", "individuelle Vorsorge f\u00fcrs Leben", "Kiera Chaplin Alain-Fabien Delon Wien", "Ex-General Mladic V\u00f6lkermordes schuldig", "Erg\u00e4nzende Methoden", "Frau perfekte Methode , Snacks Kino schmuggeln", "Bauherrenpreis : sehen Sieger", "50plus Jobmarkt - Tatsachen Tipps", "Schule Verk\u00e4ufer", "Film-Vorbilder steigern Leistung Jugendlichen", "\"   laut \"", "Tipps : w\u00fctenden Kunden", "Aufschub Steuerlast Firmenpension befl\u00fcgeln", "Neuburger Wurst Wurst", "Staud \u2019s baut", "dm Regionalit\u00e4t Zug Italien", "Abdr\u00fccke Sportstars versteigert", "Sportler Konzerne verpflichten", "Varta steht Batterien Elektroautos Bremse", "Kampf Investoren beste Immobilien h\u00e4rter", "Liste Pilz pr\u00e4sentiert Kandidaten", "Penthouse Ex-SP\u00d6-Chef Sozialbau", "Tirol : Aufregung Penthouse Ex-Politiker", "Siemens streicht weltweit 6900 Jobs", "Schoko Zahlungsplan : Venezuela pleite", "EU-Preis Nieder\u00f6sterreich", "Frau Steuer : Coca-Cola-Spot sorgt Wirbel", "H\u00e4ngepartie Abstimmung Zulassung Glyphosat", "Creutzfeldt-Jakob : \u00dcbertragung Haut ?", "Virus   schuld Bienentod", "Lars Eidinger : , Partykeller Eltern", "Air India : Kritik Geschlechtertrennung Bord", "Faymann Ungarns Fl\u00fcchtlingspolitik : \" Erinnert dunkelste Zeiten \"", "Jahreshoroskop 2017 : Skorpion", "\" Rad-Highway \" Kopenhagen rollen", "Heidi Strobl : Fruchtt\u00f6rtchen", "BartolomeyBittmann : Duo , Orchester klingt", "Trump : Fixiert Outfits Mitarbeiter", "\" brauchen Kleinsten Lehrer \"", "Kirsten Dunst f\u00fchrt 13 altes Kleid", "Royal Navy marschierte Game of Thrones Titelsong", "Kevin Haus", "Gesch\u00e4ft Kokoswasser", "BC One : Menno gewinnt Weltfinale Amsterdam", "Tatort : \" Mord niemals Kunst \"", "Mezcal schmusen", "Babylon Berlin : Berlin , berauscht blutig", "selber h\u00f6ren", "Wellen Alsergrund", "\" Sign Week \" : Buchstaben Seele", "Interpol-Konzert Arena abgebrochen", "\" Heinzl VIPs \" : Anecken , umfallen aufstehen", "Interview Stefan H\u00e4ckel David Bogner 10-j\u00e4hrigen Jubil\u00e4um Vice \u00d6sterreich : \" Verleger Internet kapiert \"", "Gebt Sommerspritzer", "Wahlkampf . !", "Chor Beschwerde", "Lastkrafttheater : Pointen , Sehns\u00fcchte Abgr\u00fcnde", "Magenschmerzen Amadeus Award", "Nacht-Panorama", "Manuel Rubey : \" operiere Herzen \"", "Wiener Linien", "Socken gekommen", "Italien , Extreme kennt", "\" Endabrechnung \" : Rotwein , Freundschaft Rachefeldzug", "Politik braucht F\u00fchrer , F\u00fchrung", "\u201e Bill Cosby Show \" : Earle Hyman gestorben", "Umstrittener Neurochirurg Canavero Gehirn transplantieren", "hr-lounge Ost feierte 5-Jahres-Jubil\u00e4um", "f\u00fcrchten \u00d6sterreicher Alter", "WHO warnt \" verstecktem \" Zucker", "Stra\u00dfburg ber\u00e4t Amtsverbot Berlusconi", "Panik London : Polizei befragte M\u00e4nner", "Anleihen Aktien kaufen ?", "Trump zieht : Einfuhr Elefanten-Troph\u00e4en Eis", "Inselh\u00fcpfen Karibik", "Eishockey : Tore EBEL-Spiele Sonntag", "Ronaldo-Freundin : Kritik Video", "Florian Holzer : Top 5 : Sushi , 2", "Orientteppiche - Besonderheiten beliebtesten Herkunftsl\u00e4nder", "Charles-V\u00f6gele-Filialen Anfang 2018 OVS", "Null Fl\u00fcchtlinge : T\u00fcrkis- Blau kippt Obergrenze", "6-Euro-Bodylotion schw\u00f6rt Meghan Markle", "Umfrage : Jamaika-Aus stiegen Union SPD W\u00e4hlergunst", "Paprika , Sanddorn , Hagebutte , Guave : Obst- Gem\u00fcsesorten Vitamin C Orangen", "Sara Shakeel : Frau feiert Dehnungsstreifen", "krank Naddel ? schwach Auftritt", "Plus-Size-Models zeigen Wahrheit \" perfekten \" K\u00f6rpern", "freizeitTIPPS : Sport , Landlust , DIY , Kinderwelt - ausgesuchte Tipps \" 7 Freizeit \"", "Leben Kate Moss : Ern\u00e4hrung & Sport", "Stieftochter missbraucht : Burgenl\u00e4nder Gericht", "Ir\u00e9na Flury \" Neapolitanische Saga \u201c Elena Ferrante", "ANB & AGB", "Million Kinder betreut", "Emmanuel Macron : Afrika : Frauen bekommen Kinder", "Wirtschafts-Staatsanwaltschaft ermittelt Chefs Wienwert", "Naddel Abd el Farrag : obdachlos ?", "# Metoo-Debatte dringend weitergef\u00fchrt geh\u00f6rt getan", "\" traurig   politischer   \"", "Red Bull bietet Sabitzer 4,5 Millionen Euro", "M\u00e4uselchen u.a.", "Verdichtet , gedichtet , gezeichnet", "3 . Juli 1914 : \" Trauer verboten \"", "\" Nimm Vergn\u00fcgen ernst \"", "Jugendliche Aborigines australischen Gef\u00e4ngnissen gefoltert", "Wieso Parfum niemals Haut verreiben", "Geburt : Frau steht K\u00f6rper", "Drogerie : gef\u00e4hrlich Testen Make-up ?", "Fitnessarmb\u00e4nder Di\u00e4ten konterkarieren", "Skispringen : Slowene Damjan gewinnt Ruka voran , Kraft 13 .", "hastiges Essen Gesundheit schadet", "Heidi Strobl : Knuspriges Bauchfleisch", "Toter Fl\u00fcchtlingsbub : Bruder Obsorge", "Ausdrucksstarke Businessfotografie", "Best of : Fresh New Music", "Physiker Karriere-Formel", "5 Koffeinarme Alternativen Kaffee & Schwarztee", "Krankheiten fluguntauglich", "Verhandlungsmarathon : M\u00fcde K\u00f6pfe verhandeln", "Soldaten t\u00f6teten m\u00e4chtigen Verbrecherboss Kolumbien", "Paradise Papers : Spuren f\u00fchren \u00d6sterreich", "Tennis : Frankreich gewinnt 10 . Mal Daviscup", "Hofer vs. VdB ATV : Heumarkt", "Minderheitsregierung deutscher Ordnung ?", "20 Fakten \" Flucht \"", "\" Scharia-Polizei \"", "Paranoider   \" Geiselnehmer \" verschwand Pflegeheim", "Opernball 2018 : Dolce & Gabbana entwerfen Diadem", "geheime Welt Queen : McDonalds & Musicals", "Jahreshoroskop 2017 : Fische", "\u00d6VP FP\u00d6 Steuerflucht Web-Firmen unterbinden", "Schwangerschaft Diabetes", "Do&Co Gesch\u00e4ft Essenszusteller mitmischen", "Ohrwaschl : Verbimsung", "Trump Time-Magazin : \" Wahrscheinlich \" Person Jahres", "liebe : Weinviertel", "Sex Freizeit : . .", "SP\u00d6 fettet Abgeordnetengehalt Christian Kern 6129 Euro", "Gef\u00e4ngnisseelsorger berichtet radikale Muslime", "Einkommen angemessen ?", "Schwedische Frauen bekommen \" Mansplaining-Hotline \"", "Arielle Calderon : Frau verzichtete 30 Zucker", "Charlene Monaco : Gabriella & Jacques offizielle Termine", "Silberstein-Aff\u00e4re : meisten Fragen bleiben", "Eishockey : Caps gewannen EBEL-Schlager Salzburg 5:4", "Falschmeldungen EU-Botschaftertreffen Van Bellen", "normale Familie Banane", "Radikaler Raster Superstudio", "Steirischer Arzt : Urteilsbegr\u00fcn\u00addung bewertet Aussehen Zeugen", "Jahreshoroskop 2017 : Krebs", "EU verbietet Geoblocking : Online-Kauf H\u00fcrden", "Austro-T\u00fcrken T\u00fcrkis-Blau erwarten", "Witzigmanns Welt : Kochen Preis", "Kaffee Kaufrausch : Lokale erobern   Einkaufszentren", "\" Terror \" Kammerspielen : Feuer Philosophiekanone", "Anna Victoria : Instagram : Bloggerin \u00fcbt Kritik Fake-Perfektion", "Rendi-Wagner sieht Kindergartenvereinbarung \" Schritt \"", "Kim Kardashian & Kanye West : Strenge Vorschriften Leihmutter", "American Music Awards 2017 : modisches Gruselkabinett", "Finanz- Wirtschaftsministerin : setzt Casinos-Managerin", "Melania Trump : Luxus-Outfits Saudi-Arabien", "Neuerliche Millionen-Pleite Steinmetz-Betriebes", "Wof\u00fcr Kaffeesatz verwenden", "Vulkan Bali : Ascheregen Flugausf\u00e4lle", "Junge Frau sammelt 280.000 Dollar Obdachlosen", "Ger\u00fcmpel Hausflur : zahlt Entsorgung ?", "Pavlova : Dessert schafft", "Transgender-Kind Montessori-Schule unerw\u00fcnscht", "K\u00fcrzester internationaler Linienflug Welt gestartet", "Palmers kassiert Shitstorm Osterh\u00f6schen", "Gr\u00fcne Landesr\u00e4tin S\u00f6lden-Tunnel", "Brad Pitt : \" Richtige existiert Angelina Jolie \"", "\" Tiefpunkt \" : Kylie Jenner Babykilo-Krise", "Jahreshoroskop 2017 : Widder", "\" Merkelismus \" : Rufe Merkel-R\u00fccktritt", "Bl\u00fcmel : \" schneller Deutschen \"", "\" Women of the Year Awards \" : Drew Barrymore pfeift aufs Abendkleid", "Heinz Fischer mobilisiert \" Ja/Nein-Demokratie \"", "Rolls-Royce-Manager Airbus-Verkaufschef", "Sammy the Seal : Vertriebene Robbe Internet-Star", "Stimmt 's : Eignen N\u00fcsse Backen ?", "Auktion : 17 Millionen Rolex Paul Newman", "Pension", "Peter Simonischek : sch\u00f6nsten Pl\u00e4tze steirischen Weinland", "Kitzm\u00fcller Steger : wertkonservativ liberal", "Deutsche italienische Urlauber bessern N\u00e4chtigungsstatistik", "Sonnenfinsternis 2019 : Tickets 200 Euro chilenischen W\u00fcste", "Ohrwaschl : Punsch !", "Investieren : Uhren Wertanlagen ?", "Studentin bezahlte Zivilcourage Spitalsaufenthalt", "Dieter Bohlen Naddel : \" Juhnke umsaufen \"", "Pleite Just Taste", "Top 5 : Bierg\u00e4rten Land", "Erdbeben ersch\u00fctterte Inselstaat Papua Neuguinea", "ORF-Streit : Wrabetz-R\u00fcge \" Report\"-Chef", "\" B\u00fcrger f\u00fchlen Druck \"", "H\u00fcrden Weg Pakt Kurz-Strache", "Kalchgruber versteckte Fliehloch", "Herzogin Kate tr\u00e4gt junges Label Self Portrait Filmpremiere", "Wieso Prinz George langen Hosen sieht", "Zucker : Wissen , Zucker Fruchtjoghurts steckt ?", "Tennis : Ex-Wimbledonsiegerin Jana Novotna Alter 49 gestorben", "Wiener SP\u00d6 : Allianzen Pr\u00e4ferenzen", "Instagram : Fitnessbloggerin Celia Learmonth gesteht Essst\u00f6rung", "K\u00fcrbis !", "Kreatives Sesselspiel : 40 Magis", "Filmwunder Zeiten Kinorevolution", "Nagelh\u00e4rter st\u00e4ndig verwenden", "bleibt Revival ?", "Rezept : Schokopudding Oma Opa", "Meghan Markles Verlobungs-Outfit : Sch\u00f6n , perfekt", "Lake-Louise-Abfahrt : Feuz schneller Mayer", "Insekten essen : Frankreich Munde", "Kopfschmerzen Durchfall : Rosenwasser", "\u00dcberLeben : Kaffee m\u00fcde", "Peter Klien : Reporter , Robert Lugar aufs Klo fl\u00fcchtet", "Brand Grenfell-Tower : Tote vermutet", "Zw\u00f6lf Seeleute Schiffskollision S\u00fcdchinas K\u00fcste vermisst", "Internet gekaufte Matratze besch\u00e4ftigt EuGH", ": perfekt , unsterblich \u2013 bereit ?", "Tiroler ?", "8 . Juli 1914 : Scharfe T\u00f6ne \u2013 Folgen Attentats", "Bauern f\u00fcrchten Zukunft Zuckerr\u00fcbe", "Van Bellen Hofburg : \" \u2019s , euer neuer Pr\u00e4sident \"", "Menasse : \" nationale Weg f\u00fchrt Desaster \"", "Promis Thanksgiving feiern", "4 Gesunde Essgewohnheiten , Di\u00e4ten", "\" Schwarzes Gold \" St\u00f6r", "Rekorderl\u00f6s diamanten\u00fcberzogene Hermes-Tasche", "verheerenden Anschlag Sinai deutet Spur IS", "Jahreshoroskop 2017 : Wassermann", "Wiener SP\u00d6 : Ludwig sieht \" M\u00f6glichkeit Koalition FP\u00d6 \"", "Henry Zug : Arbeitsinspektoren erstatteten mehrere Anzeigen", "Sexismus schadet M\u00e4nnerwelt", "14 . Juli 1914 : Frauenmord ersch\u00fcttert Wien", "Strache : \" durchgesetzt \"", "Treffpunkt Wien : Interview Vampir", "Roboter\u00e4rzte : Europa Milliarden sparen", "\" Heimatschutz \" \u2013   Education ?", "Jamaika : Merkel bot Seehofer Ministeramt", "Mama , Narrativ ?", "Hillary Clinton Niederlage getan", "verlorene Kindheit Tschechien", "\u00c4rztin Info Abtreibung Website verurteilt", "UNO-Tribunal f\u00e4llt Mittwoch Urteil Ratko Mladic", "Panama Papers : Emma Watson Verbrecherin ?", "Koalitionsverhandlungen : FP\u00d6 ORF-Geb\u00fchren F\u00f6rderung offentlich-rechtlicher Inhalte ersetzen", "Herzogin Kate : Infos angebliche Zwillingsgeburt", "Kopftuch : Shitstorm Bipa", "Parifizierungsfehler korrigiert ?", "Redaktionsstatut", "November Privatkonkurs Mindestquote", "Attentat Sarajewo : geschah 100", "Studie : LED-Lampen f\u00fchren weltweit Lichtverschmutzung", "Kinderkonferenz : \" Kinder wichtiger Geld \u2026 \"", "Werbung : zeigen Uhren", "Krebs : 9-J\u00e4hriger feiert letztes Weihnachten stirbt", "Jahreshoroskop 2017 : Sch\u00fctze", "Temperatursturz : F\u00f6hn Kaltfront", "Daniela Katzenberger erntet Shitstorm Di\u00e4t-Buch", "4 Ideen B\u00fcro-Outfits Winter", "Fitnessarmb\u00e4nder Wearables : bringt Self-Tracking ?", "Suizid Fl\u00fcchtlingsbuben : Elfj\u00e4hriger \" integriert \"", "K\u00f6rper innerhalb Stunden \u00e4ndern", "R\u00fcckruf Kindersekt \" Robby Bubble \"", "Australian Open bringen Premiere Service-Uhr", "Trumps Steuerreform nimmt H\u00fcrde", "Wahlen Wendepunkt", "Irvin D. Yalom : letzte Buch", "Siemens-Gr\u00fcnde umgewidmet", "Andreas Khol : \" Regierung steht Dezember \"", "5 Paar Schuhe , Frau besitzen", "Neos warnen schwarz-blauem ORF", "\" Happy End \" : Fluch Familie", "Meister wert ?", "Lagerfeld : Fl\u00fcchtlinge \" schlimmste Feinden Juden \"", "Fu\u00dfball : Saisontreffer Gorgon Rijeka-Ausw\u00e4rtssieg", "T-Shirts : Woher L\u00f6cher", "Aktion 20.000 : \" letzte Chance \"", "Christina Aguilera : wiederzuerkennen dicken Lippen", "ALDI : Kassierer Alkohol verkaufen", "Georgia Dome Atlanta gesprengt", "Koalitionsverhandlungen : frisches Geld Schulen", "Studie zeigt : Yoga f\u00fcrs Gehirn", "Paaradox : sagend !", "Palmers : Werberat verurteilt \" Osterh\u00f6schen\"-Kampagne", "Essay Guido Tartarotti : faul", "unbedingt Latein", "Kneippkuren Kneipentouren ?", "Frage", "Baggerwette ?", "Tua ma Schweindi mochn ?", "Tontaubenschei ...", "Angelschein", "LEBEN : Weihnachten mitten", "LEBEN : f\u00e4ngt Leben", "LEBEN : Kinovergn\u00fcgen", "LEBEN : sch\u00f6ner !", "LEBEN : Aufgeschwemmt", "LEBEN : Prinz & Puppe", "Frage", "Wilde H\u00fchner", "10 Meter", "Urschl ! Augen ! Lack !", "Bulldoggen Puppenhaus", "?", "Nichtsein", "Beihilfe Selbstbetrug", "Passt soweit ?", "Nich ' ?", "Geschenks-Berg", "Hahn ?", "Buch Schnecke", "Statussymbol Essen", "Babyaffi denkt elegant", "Herwart fegte 180 km/h \u00fcbers Land", "Jahreshoroskop 2017 : L\u00f6we", "Fu\u00dfball : ManUnited besiegte Brighton 1:0 , Tottenham 1:1", "Premiere : Nina spielt Feuer", "5 12 Semmering : Neues Tragseil l\u00e4sst hoffen", "20 Fakten \" Indiana Jones \"", "Florian Holzer : Top 5 : Kulinarische Pop Ups", "Otto-Werbung Guido Maria Kretschmer : \" L\u00e4cherlich \" \" respektlos \"", "2 . Juli 1914 : Trauer \u2013 Rapid", "Chinesischer Internetriese Tencent wertvoller Facebook", "Sehnsuchtsorte Bergen", "4 wichtigsten Concealer-Tipps Visagisten", "Bad Gastein : \" brauchen mittelm\u00e4\u00dfiges Apartmenthotel \"", "Charles Manson : Star Sektenf\u00fchrern tot", "Wien : Lokf\u00fchrer starb schwerem Sturz Zug", "\" blauem Auge davongekommen \"", "Moser-Pr\u00f6ll : \" wehren gewusst \"", "Profis Portfolio \u00fcberpr\u00fcfen", "Thomas Brezina spricht Hochzeit Freund", "Himalaya Hollywood", "US-Ex-Gymnastin : Essay sexuellen Missbrauch", "Kelsey Wells : 3 Bildern liegen 8 Kilogramm", "gr\u00f6\u00dften Energie-Mythen", "Herzogin Kate : Prinzessin-Regeln Meghan Markle lehren", "US-Schauspieler Rance Howard 89 gestorben", "stylishsten Hochzeiten Jahres 2016", "Arzt Kinder s\u00fcchtig", "Scheine \u2005 Masse", "Bedingte Haft Investor Benko", "W\u00f6rter , vermissen", "Paaradox : Fall   Blabla", "Paaradox : Getrennte Wege", "Tanz !", "Paaradox : Kipferlkunst", "Paaradox : Hoch-Zeit Ballerei", "Paaradox : Verstoppertje", "Paaradox : : Verkehrte Welt", "Zug-Nummer", "Plan , Werk", "Sommer naht", "Paaradox : Herz Schnee", "Paaradox : Viren", "Paaradox : Einkaufs- Lasten", "Paaradox : Legende Dickmann", "Paaradox : Frau Herr Deppert", "Paaradox : Daniel Monica", "Paaradox : 2014", "Paaradox : Aszendent   Gem\u00fcse", "Paaradox : Marktt\u00fccke", "Paaradox : Zweierlei Licht-Blicke", "Paaradox : Kipferldiskussion .", "Adidas Puma sehen Rivalen", "Bodenst\u00e4ndigkeit Protz", "Dean Martin : Geheimnisse Lebens", "Autismus : Fu\u00dfball therapeutisch wirkt", "Black Friday 2017 : Mode-und Beauty-Sales", "AVZ-Stiftung : gewonnen , zerronnen", "\" letzten Mann \" : philippinische Armee IS k\u00e4mpft", "Mariahilfer Stra\u00dfe Fl\u00fcchtlingsportr\u00e4ts gepflastert", "Insolvente Fill Metallbau streicht 31 Jobs", "\u00dcbergriffsvorw\u00fcrfe Pixar-Animationsguru Lasseter", "Erde Neandertaler erz\u00e4hlt", "Angel Shot : USA : Getr\u00e4nke-Code Frauen Bedr\u00e4ngnis helfen", "Lukas Resetarits \" Angst vorm Hoferl \"", "Victoria 's Secret : Gigi Hadid Teilnahme Shitstorm", "\" Black-Friday \" : Streiks Amazon Deutschland", "\" Verfechterin ausgewogener Mischkost \"", "Pizza Neapel Weltkulturerbe", "23 . Juli : \u00d6sterreich-Ungarn stellt Serbien Ultimatum", "Heidi Strobl : Entenbrust Orangen-Portwein-Sauce", "Lord Sir rosa Sonnenschirm", "Gesundheit Hund : Kardiologe", "Donald Trump Klebeband Krawatte", "Zieht Donald Trump absichtlich ?", "Neues Ger\u00fccht : Zwillinge William Kate ?", "Foto Geschenk", "kriegen Lampenfieber Griff", "Top 5 : Autobahn", "Jahreshoroskop 2017 : Waage", "Steffi Graf & Andre Agassi Kind adoptieren", "Unglaubliche Ajda Pekkan : t\u00fcrkische S\u00e4ngerin 71", "Stephen King schlafen Frauen", "Studie . Elektrostimulation Gehirns hilft Abnehmen", "Caitlyn Jenner enth\u00fcllt : O. J. Simpsons Anwalt Robert Kardashain glaubte Schuld", "Silbermond-S\u00e4ngerin spricht Baby-News", "halbes Jahrhundert Gast", "Lebensmittel : Tarnen T\u00e4uschen Verpackung", "Kaczy\u0144ski liest Katzenbuch Parlament", "Neues Restaurant Delikatessengesch\u00e4ft : Einmacherin er\u00f6ffnet", "Frau Mansplaining-Beispiel gemansplaint", "Dittlbacher warnt \" Widersachern \" au\u00dferhalb ORF", "Salz & Pfeffer : Jamie \u2019s Italian", "Hundertausend fl\u00fcchten Vulkan Bali", "Til Schweiger gewinnt Prozess Facebook-Eintrag", "Trick : Laufmaschen Strumpfhosen", "Italienischer Wein beliebter", "Shitstorm Lidl schwarzem Model", "42.000 Bootsfl\u00fcchtlinge Operation \" Sophia \" gerettet", "Eishockey : Grabner NHL Tor Sieg \u00d6sterreicher-Duell", "Sex-Untriebe Ultra-Religi\u00f6sen", "3 Zeichen , Unterw\u00e4sche brauchen", "Arbeitskr\u00e4fteangebot \u00d6sterreich verteilt", "Haar-Trend 2017 : Blond dunklem Ansatz", "OMV-Chef h\u00e4lt   Nord Stream fest :   \" Sache USA \"", "umsatzst\u00e4rksten Unternehmen \u00d6sterreichs", "Brillenmarke Ace & Tate er\u00f6ffnet Wien", "Welpen-Handel gef\u00e4lschten Papieren", "Image-Problem Periode", "Trump nimmt Steuerreform Angriff", "Prinz Harry : Schauspielerin Meghan Markle Freundin ?", "Instagram l\u00f6schte Foto 25 altem \" profil\"-Cover", "SP\u00d6 schweigt Gusenbauers Gesch\u00e4ften", "Haarausfall : Frau verwandelt Kopfhaut Kunstwerk", "Hamilton Freitag Schnellster Abu Dhabi", "Redaktion Salzburg", "LIVE : ORF-Duell SP\u00d6-Chef Christian Kern FP\u00d6-Chef Heinz-Christian Strache", "Sex-Wissen : Kuss-Verboten weiblichen Erektion", "Offenlegung gem. \u00a7 25 MedienG   KURIER", "Gewerkschafter warnen , Lehrer l\u00e4nger unterrichten lassen", "Air Berlin stellt Hunderte Mitarbeiter frei : K\u00fcndigung November", "Brand ehemaligem Bordell Deutschlandsberg d\u00fcrfte gelegt", "National Institutes of Health : PMS : Biologischer Mechanismus PMS-Beschwerden entdeckt", "\u00d6SV-Damen : \" Super Klima Mannschaft \"", "Sch\u00f6nheit Architektur Bau , fotografisch festgehalten", "Nepal : Tempelh\u00fcpfen Schatten Himalaja", "Kenzo : verr\u00fcckteste Parfum-Werbung Zeiten", ", Parfum aufgespr\u00fcht ?", "Trick : h\u00e4lt Parfum", "Mindestsicherung : L\u00e4nder , Regelungen", "Digitalisierung Chance Frauen", "Opel Kira Gr\u00fcnberg : halten \u00d6sterreichs Abgeordnete Geschenken ?", "Studie : gesund Sportverein", "Ex-\u00d6FB-Talent Bytyqi Karriere beenden", "Nina Proll legt # metoo-Debatte : \" kollektives Jammern \"", "bedeutet Servitute ?", "Clinton ungewollten Umarmungen Trump ausgewichen", "alter Werft neuer Stadtteil", "FC OMV G\u00e4nserndorf S\u00fcd : wunderbare Verlierer", "Best of : African Summer", "Best of : Lass Sonne rein !", "Best Of : LATIN POP", "Best of : neu &", "Stars Woche :   Les Amazones d'Afrique", "Star Woche : KEHLANI", "Star Woche : SOLANGE", "Sch\u00f6n scharf : Balkan Beats", "Star Woche : SEVDALIZA", "Star Woche : Inna Modja", "Ewig sch\u00f6n", "Star Woche : Kylie Minogue", "La Brass Banda Mitrei\u00dfender Mix Blech", "Siedler ihren H\u00e4usern parken", "Camila Alves Wohlf\u00fchlkilos", "Jugendwort Jahres : bedeutet \" I bims \" ?", "  Land billigeres \u00d6ffi-Ticket Feinstaub-Saison", "Poller-\"Abwehrkampf \" Kleinstadt", "Berufsverbot   Hausarzt :   Patienten", "T-Shirt Selbstliebe", "KURIER Newsletter - up-to-date .", "3 Tricks , Visagisten schw\u00f6ren", "Birgit Denk radelt Meer", "Florian Holzer : Top 5 : Tr\u00fcffel-Events", "Marion Mitterhammer beschenkt", "R\u00fcckruf : Popp Feinkost-Salate Kunststoff-Teilchen enthalten", "Decke", "FP\u00d6 klagt VfGH-Richter Johannes Schnizer", "Schlierenzauer Training Bergisel \" schmerzfrei \"", "Tipps : misten Ihren Kleiderschrank", "Liebesouting : Maria K\u00f6stlinger zeigt erstmals Juergen Maurer ROMY 2016", "\" M\u00e4nner verbieten ? \" Nina Proll \u00e4rgert Bel\u00e4stigungs-Debatte", "Strache ringen richtige Dosis direkte Demokratie", "\" Frau Franzi \" : K\u00f6nigliche Fetznsch\u00e4deln Tschinn-Bumm", "5 \u00fcberraschende Ursachen Pickel", "Social Media Trend : Fitness-Fotos Betrachter wirken", "Flirt sexuelle Bel\u00e4stigung : liegt Grenze ?", "Wieso Wetter-Ladiys gleiche Kleid tragen", "Einmalige Momente festhalten", "Generationen-Portr\u00e4ts Berufsfotografen", "Tipps Jetlag : beste Trick , Jetlag loszuwerden", "\" Pinocchio \" Volksoper : bezaubert Nachwuchs", "Sprachen : verst\u00e4ndigte k. u. k. Armee", "TV-Tipp : 20 Fakten Harry Potter", "5 Trends , Frauen Kurven stehen", "fossile Energie", "SPD r\u00fcckt Neuwahlen - Druck Schulz w\u00e4chst", "Angelina Jolie : Hochzeitspl\u00e4ne Gesch\u00e4ftsmann ?", "Wissenschaft : \u00e4ltesten Wein-Funde Welt Georgien entdeckt", "Assad trifft Putin Sotschi", "Experimentierfreudige Jugendliche", "Donald Ivanka Trumps K\u00f6rpersprache aussagt", "15 Identit\u00e4re Paris festgenommen", "O\u00d6 : Wirt lie\u00df \u00d6VP-Spitze Restaurant speisen", "Schn\u00e4ppchen-J\u00e4ger : Clever shoppen Ausverkauf", "Vitamin D herbekommen", "Luxus Fiona ? Swarovski shoppt Mailand", "Betreiber Waldsanatoriums", "Forscher l\u00fcften Geheimnis Orgasmus", "Suche U-Boot : Marine Explosion", "Round Table : Nachl\u00e4ssiger Geld-Umgang", "L\u00fcckenschluss St. P\u00f6lten - Loosdorf Inbetriebnahme", "Staatsunternehmen : Staat privat", "Nick Carter : S\u00e4ngerin Vergewaltigung bezichtigt", "KURIER News direkt WhatsApp", "Crashtest Depot", "Intrige Bundespr\u00e4sident Alexander Van Bellen : \" Protokoll \" Fake", "\u00d6SV-Missbrauch : Tirol richtet Anlaufstelle", "Hallo M\u00e4nner !", "Pikant : Vanessa Paradis liebt Ex Freundin", "Oh , it 's Tee !", "FP\u00d6 ORF umbauen", "Jahreshoroskop 2017 : Zwillinge", "Koalitionsverhandlungen : harten Brocken lauern", "Stadt-Land-Gef\u00e4lle Gehaltserh\u00f6hungen", "Bogdan Ro\u0161\u010di\u0107 : L\u00e4rm ( Adorno )", "Ohrwaschl : Nacht", "\" Sekten\u00e4hnliche Strukturen \" : Beh\u00f6rde Privatschule Visier", "Weltkrieg :", "170-Kilo-B\u00e4r verendet Kollision Auto", "\u00d6sterreicherinnen sexuell bel\u00e4stigt", "Greenpeace : Gesundheitsgefahr Palm\u00f6l", "Schatzsuche J\u00fcngsten", "Fotos : Victoria 's Secret Fashion Show 2017", "Pizza : New Yorker Ratte mampft Avocado", "Dresden : Nazispr\u00fcche : Sch\u00fclerin zeigt Klassenkameraden", "Facebook-Pr\u00fcgelvideo : Grenzen Gewalt Netz", "V\u00e4ter verweigern Handschlag Lehrerinnen", "Wettautomaten : Stadt Ger\u00e4te retournieren", "Dubiose Gesch\u00e4fte ermordeten Baumeisters", "Home Invasion D\u00f6bling gekl\u00e4rt", "Passagierfrust Flughafen-Chaos", "Marina H. : \" gelacht , geschlagen \"", "15-J\u00e4hrige U-Haft : \" tut leid , passiert \"", "Pr\u00fcgelvideo   Facebook , Verd\u00e4chtige Angst", "Pr\u00fcgelvideo : \" erreicht , \" - Aufmerksamkeit", "Wohnen Grau", "Priscilla Presley schockt Fans Beauty-OP-Gesicht", "Entgleisung : FP\u00d6-Spitzenkandidat Udo Landbauer nennt Mikl-Leitner \" Moslem-Mama-Mikl \"", "Schulen Japan fordern Kindern schwarze Haare", "Russland : 986-fach erh\u00f6hte radioaktive Strahlung gemessen", "Talente-Checks Sch\u00fcler scheitern Gymnasien", "Putin sieht \" echte \" Chance Beendigung Syrien-Konflikt", "Norman Dyhrenfurth : Bergsteigerlegende Himalaja-Expedition", "Familie , Bergfieber packte", "Haftstrafe Pistorius 13 erh\u00f6ht", "Top 5 : Bierg\u00e4rten Wien", "Pr\u00e4sidentenwahl Honduras : Wechsel Kontinuit\u00e4t", "UNIQA trotzt Sturm Zinstief", "Pink : Sommertrend tragen", "Salzburg w\u00e4hlt Schaden-Nachfolger : Wahlbeteiligung Unbekannte", "Ungewohntes , instabiles Deutschland", "Oh Tannenbaum , Oh Tannenbaum", "Landwirte , Gr\u00e4ber schaufeln", "FP\u00d6-Verhandler : \" Heil Deutsche Burschenschaft \"", "Wien : Fahndung mutma\u00dflichem Vergewaltiger", "Europa-League-Chance gewahrt : K\u00f6ln bezwingt FC Arsenal 1:0", "Burschenschafter oberster Verfassungssch\u00fctzer \" unvorstellbar \"", "Krieg Syrien fest Griff", "Schn\u00e4ppchen : teuer Super Bowl-Ring", "4 Stil-Geheimnisse Franz\u00f6sinnen", "Target : sieht Victoria Beckhams Billig-Kollektion", "4 BH-Fehler , Frauen", "5 BHs Frau besitzen", "BH waschen", "Umfrage : BH fast Frau tragen", "Seidl Ruka bester \u00d6SV-Kombinierer", "\" Armut Saison \"", "N\u00e4chster Fahrer Uber fahren", "Kate Middletons Haarstylist : gelingen Locken", "Royals : Prinz George Kleidungsvorschriften", "Label besitzt Queen 200 Handtaschen", "Handtasche wertvoller Diamanten", "Mode-Tipps : stylen schlank", "Studie : Schuhen Bakterien WC", "Bildung Religion zusammenh\u00e4ngen", "Harvey Weinstein verkauft Villa Hamptons : Bilder", "Wien : U4 gesperrt", "\u00d6VP-Abgeordnete Kira Gr\u00fcnberg kauft Opel geschenkte Auto", "Stephan Eberharter : Leben langweilig , passiert \"", "Veranstaltung \" Wege selbstbestimmten Leben \"", "O.J. Simpsons Justizgroteske , Folge Folge", "Baustart Green Building Aspern", "Depot krisenfest", "Schnelles Rezept : Antipasti selber", "Rezept : Himmlisch : Schokoladenkuchen essen", "Rezept : einfachste Brot-Rezept Welt", "Plus-Size-Trend : Germany 's Next Topmodel setzt Kurven", "Grundbira : Wiens L\u00e4ndle-Grei\u00dfler er\u00f6ffnet", "Red-Bull-Akademie : Salzburg \u00fcbertrumpft Barcelona", "T\u00fcrkei droht Niederlanden \" schwersten \" Ma\u00dfnahmen", "Deutschland - \u00dcbergriffe Frauen Silvester : Aufschrei Exzess K\u00f6ln", "spricht Harvey Weinsteins Psychologe", "Caroline Monaco : Verliebt Milliard\u00e4r ?", "Yoga Depressionen : Sudarshan Kriya : Atmen Antidepressivum", "Hans Peter Doskozil : R\u00fcckkehr Burgenland", "EZB : \u00d6sterreicher Bargeld B\u00f6rserl Euro-Schnitt", "Nationalrat : Parteigehalt Abgeordnete Seltenheit", "\u00d6SV-Pr\u00e4sident Peter Schr\u00f6cksnadel Interview : \" Diktator . Leadership \"", "Konrad Paul Liessmann : gebildete ausmacht", "Formel 1 : Poleposition Bottas Abu Dhabi", "Wiener Gr\u00fcne : Landesversammlung Zeichen Krise", "Chinas U20-Gastspiel Bayern steht", "Basketball : 14 Punkte - P\u00f6ltl stellte NBA-Karriere-Bestleistung", "Nepal : \u00d6sterreicher P\u00e4dophiler Haft", "Evan Spiegel : millionenschwerer Gro\u00dfkotz ?", "Leitartikel Neutral bisschen", "gr\u00f6\u00dften Baustellen SP\u00d6", "23 EU-Staaten legen Grundstein Verteidigungsunion", "Theologen Tierrechtler Verh\u00e4ltnis Haustier Nutztier : Tiere Himmel ?", "Christiane H\u00f6rbiger : \" Gerhard T\u00f6tschinger starb Hochzeit \"", "Modetrends 2017 : Schleifen", "Deutschland : Gyn\u00e4kologin \" Werbung \" Abtreibung angezeigt", "wichtigsten Punkte FP\u00d6-Wahlprogramm", "Haute Couture : kauft s\u00fcndhaft teuren Kleider ?", "Model Ashley Graham feiert Bauchr\u00f6llchen", "Zara regt \" Love Your Curves\"-Kampagne", "Shitstorm : Victoria 's Secret \u00fcbertreibt Photoshop", "Oberster Sanit\u00e4tsrat einstimmig Rauchverbot Gastronomie", "700 Kilogramm Kokain Jacht Australien aufgesp\u00fcrt", "Lippenstift-Trend Winter 2017 : Glanz Glitter", "Florian Holzer : Top 5 : Thanksgiving-Truthahn", "Singlek\u00fcchen : Preis , Wirkung - Auswahl XXXLutz", "Ana Ivanovic & Bastian Schweinsteiger erwarten Baby", "Josh Lee : Student tr\u00e4gt 15 Monate Jeans", "Hickersberger Druck", "R\u00fcstungsindustrie stellt neu", "Explosion China Kl\u00e4rgrube ausgel\u00f6st", "Steirischer Arzt : Urteilsbegr\u00fcndung Versto\u00df Ethikerkl\u00e4rung", "Kellyanne Conway glaubt , Debatte sexuelle Bel\u00e4stigung angesto\u00dfen", "Roter Aufschrei \" Aktion 20.000 \"", "Kopfb\u00e4lle Kontaktsport : Schwere Hirnsch\u00e4den", "\" eher schuldig \" : Regisseur P\u00f6lsler \" Terror\"-Neuinszenierung", "Ottakringer setzt Bier-Wein-Kreation", "UN-Beamter warnt : Anschl\u00e4ge umgebauten IS", "Video : Hochzeitskleider 100 ver\u00e4nderten", "D\u00fcnner Pizzabodenvergleich erz\u00fcrnt Victoria Beckham", "Auszeichnung   Qualit\u00e4ts-Journalismus", "Julia Fischer \" Madame Curie \u201c Eve Curie", "Victoria 's Secret : China Stolperfalle", "Fall Aslan G : Mutma\u00dflicher Sechsfachm\u00f6rder Kaution enthaftet", "Tabletten teilen : gef\u00e4hrlich , Tabletten halbieren ?", "Mann versteckte Autoreisezug : Lokf\u00fchrer st\u00fcrzte", "Tesla pr\u00e4sentiert Elektro-Lkw Sportwagen", "Maroni-Rezepte : Katharina Prato Maroni", "Geplant : Prinz Harry arrangierte Kennenlernen Meghan Markle", "Saudischer Kronprinz nennt Khamenei \" Hitler \"", "OECD liest Leviten : Nahrung VP-FP-Raucherstreit", "Tanztheater : Hirn Bauch ? \u201e \u201c ?", "Rauchverbot Gastronomie - Lungenfach\u00e4rzte Verbot", "Fr\u00fchst\u00fcck Philipp Hochmair", "Urban Nation : Graffitis Museum", "25 \u00d6tzi :", "Ricotta-Basilikum-Nockerln", "Vettel Schnellster erstem Abu-Dhabi-Training", "Jedermann-Protest : Wof\u00fcr bezahlen K\u00fcnstler ?", "Maria K\u00f6stlinger : \" Verdr\u00e4ngen Motor \"", "Zucker   M\u00e4nner depressiv", "Freispruch Fall Dr. L.", "Brad Pitt : Kinder Thanksgiving ?", "TV-Tipp : 20 Fakten \" Fluch Karibik \"", "20 knallharte Fakten \" Rambo \"", "TV-Tipp : 20 Fakten Titanic", "20 Fakten \" Charlie Schokoladenfabrik \"", "20 Fakten \" From Dusk Till Dawn \"", "TV-Tipp : 20 Fakten \" Columbo \"", "Relax Guide 2017 : Wellnesshotels \u00d6sterreichs", "Dresscode : ziehe Hochzeitsgast ?", "Ehemaliger SP\u00d6-Nationalratsabgeordneter Kirchgatterer gestorben", "Foundation : Wieso fl\u00fcssiges Make-up manchmal fusselt", "Zoff Hofer-Tankstelle", "Sexismus trifft   Geschlechter", "Widerrufsbelehrung", "Sexuelle Bel\u00e4stigung : Schweigen Opfer", "Generationenprojekt Christkindlmarktstand", "Salzburg : enge Korsett UEFA", "Adventm\u00e4rkte : \" Poller schrecken Terroristen \"", "Nutella : steckt Schokoaufstrich", "gr\u00f6\u00dfte Studie zeigt : Hundebesitzer leben l\u00e4nger ges\u00fcnder", "Anneliese Kitzm\u00fcller : Blaue Verhandlerin rechtem Netzwerk", "Strengere Regeln Kinderg\u00e4rten beschlossen", "Sexuelle Bel\u00e4stigung : TripAdvisor markiert Hotels", "Millionen schwerer Baubetrug : Ermittlungen \u2005 70 Beschuldigte ausgeweitet", "Bau-Krimi : Br\u00fcderpaar 30 40 Scheinfirmen betrieben", "Henry Zug : Gewerkschaft Kollektivvertrag mobile Gastronomie", "Stiftung Kindertraum hilft W\u00fcnsche erf\u00fcllen : Br\u00fcder Diabetes - fast normales Leben", "Start Zentralmatura : Aufgaben Vorjahre findet", "Koalitionsplan aussehen", "\" Komm \" : Neues Buch Emily Nagoski vermittelt Wissen weibliche Sexualit\u00e4t", "Heidi Strobl : Krautstrudel", "Trumps Ex-Berater Flynn Ermittlern kooperieren", "Langlauf : Starker Auftritt Teresa Stadlober", "Deutschland Krise \u00fcberleben", "Celine d\u00fcnner : Fans Sorge GNTM-Gewinnerin", "SP\u00d6 Wien : Kampfabstimmung Schieder vs. Ludwig ?", "Koalitionsverhandlungen : Einigung verpflichtendes Kindergartenjahr", "Gault&Millau 2018 : Hauben : Restaurants \u00d6sterreich", "Martina Ebm schwanger : Grund \" Vorstadtweiber\"-Wirbels", "Toter Fl\u00fcchtlingsbub : Fl\u00fcchtlingskoordinator Konrad warnte Beh\u00f6rde", "9/11 : World Trade Center-P\u00e4chter Airlines einig", "Naddel Nadja abd el Farrag Leberzirrhose : \" K\u00e4mpfe Leben \"", "Salz & Pfeffer : Meissl & Schadn", "Arzt Gericht : Justiz ermittelt Polit-Interventionen", "H\u00f6hle L\u00f6wen 2017 : L\u00f6wen investieren App Chef . One", "Letzte Trends : Wahltag \u00dcberraschung bringen", "Aktionstag : Flagge zeigen Fl\u00fcchtlinge", "Kreative Geschenkideen Linzer Hauptplatz", "Camilla Spanischen Hofreitschule", "KURIER trauert Reporterlegende Willi Theuretsbacher", "Mode : Basics sehen M\u00e4nner", "Stil-Knigge : Hemd Hose gesteckt ?", "FP\u00d6 Koalition : \" Blauer Innenminister Bedingung \"", "George Soros : Millionen Hass Trump-Sieg", "Texas : Zahlreiche Opfer Sch\u00fcssen Kirche", "Geistig verwirrter Anrufer drohte Sprengsatz Supermarkt", "T\u00fcrkische Doppelstaatsb\u00fcrgerschaften : Aberkennung Tirol", "Konzertreihe Klassik Dom holt Starviolonist David Garrett Linz", "Millennials   st\u00e4ndig Jobsuche", "\" Pussy Bow \" : Melania Trump erntet Spott pinke Bluse", "US-Designer Robert James protestiert Modenschau Trump", "Ivanka Trump : Heftige Kritik Metallic-Kleid", "US-Kaufhaus Nordstrom listet Mode Ivanka Trump", "Monica Bellucci dankbar Foto-Retusche", "lieben Hunde Mitmenschen", "Angeblicher Killer Aslan G. Interview", "\" Battle of the Sexes \" : Steve Carell Video-Interview", "Weide Wohnzimmer", "A.o . \" au\u00dferordentlich \"", "Salz & Pfeffer : Spittelberg", "Direkte Demokratie : Skepsis \u00d6VP w\u00e4chst", "AMS-Chef Kopf h\u00e4lt Jobbonus \" notwendig \"", "Preise Einfamilienh\u00e4user 9,4 Prozent gestiegen", "Sch\u00fcler Gerber - Friedrich Torberg", "Kultur", "Hollywood-Stars H\u00e4nde verj\u00fcngen lassen", "China : Kim-jong letzte Bombe Supervulkan geweckt ?", "aktuelle Magazin freizeit.at", "Florian Holzer : Top 5 : Essen Bahn , 2", "Wurmkiste : W\u00fcrmern Zuhause baut", "Razzia Baumafia - Drahtzieher \u00f6sterreichischer Unternehmer", "Chris Lohner : \" hab ausgelassen \"", "Gault&Millau 2018 : wichtigsten Aufsteiger", "Arm nachts taub", "James Middleton : Trennung Kates Bruder", "Henry Zug drohen 1,3 Millionen Euro Verwaltungsstrafe", "Internationales \" Times\"-Ranking : Heimische Unis fallen gro\u00dfteils", "US-Kampfpilot zeichnete Pimmel Himmel", "Herzogin Kate : Luxuri\u00f6ses Chanel-Outfit Paris", "Frau tr\u00e4gt gleiche Outfit", "Fiona Swarovski zeigt feschen S\u00f6hne", "Baukunst AllesWirdGut", "Rezept : Hei\u00dfer Aperol kalte", "M. Micallef : Suche perfekten Duft", "Beauty-Trend Duft-Layering : Parfum ,", "Nase : Tipps Parfum-Kauf", "Florian Holzer : Top 5 : Sushi , 1", "  Kronen Zeitung : Kolumne Jeann\u00e9e gestrichen", "Weihnachten : Wohnung fr\u00fch dekoriert , gl\u00fccklicher", "Risikoforscher Gerd Gigerenzer Terror Br\u00fcssel : Aufkl\u00e4rung Angst", "Schutzpatron", "Wegweiser KURIER-Archiv", "Fall Deutschland \u00d6sterreich eintreten", "Bodyblog : Ziegenyoga \u00dcberraschungen", "\u00d6VP plant Pflegeregress light", "Deutsche Gr\u00fcne Minderheitsregierung beteiligen", "hei\u00df Wiener Feuerwehr", "Nordirland : beste Reiseregion 2018", "Heikle EU-Deals : Rindfleisch droht Preisverfall", "Downton Abbey-Star Lily James Interview", "Manscaping : Gefahren m\u00e4nnlichen Intimrasur", "Trump pries \" unsichtbaren \" Kampfjet US-K\u00fcstenwache", "Ex-OMV-Chef Erne-Gruppe M\u00e4rkte Osten \u00f6ffnen", "OMV verdiente Quartal deutlich", "OMV steigt Vorarlberger Firma", "Herzogin Kate legt Camilla", "Fu\u00dfball-Bundesliga : Admira siegt Mattersburg festigt Platz", "Diabetes : besondere Risiko Frauen", "Faltengl\u00e4tten Family Business", "Kommunalkredit : Haselsteiner , Gusenbauer   Co. klagen", "Grapsch-Verdacht Volksschullehrer : 55-J\u00e4hriger sofort suspendiert", "einfach \u00d6sterreich Waffe kaufen ?", "Sally - Arno Geiger", "Spion , K\u00e4lte - John le Carr\u00e9", "Am\u00e9rica - T. C. Boyle", "Strudlhofstiege - Heimito Doderer", "Caretta Caretta - Paulus Hochgatterer", "Jugend - \u00d6d\u00f6n Horv\u00e1th", "Salz Meer - Brigitte Schwaiger", "Neuer Job : Amal Clooney Met-Gala Vorsitz", "gr\u00f6\u00dfte Bitcoin-B\u00f6rse pleite", "Lebensversicherung zahlt angelegtes Geld", "\" SAG 'S MULTI ! \" : Gift t\u00f6dlich , Geschenk \u2026", "Thomas Zach : \" Bashing Politik \"", "Neuer Krages-Chef Wels", "Christoph Seiler # MeToo lustig", "Schutz Terror : Poller Bezirksstadt", "Promis : Klarer Trend Kind", "klein Donald Trumps H\u00e4nde", "7 . Juli : Franz Joseph Ischl - The show must go on", "Schauspieler , Co-Stars feuern lie\u00dfen", "6 geniale Beauty-Rituale Nacht", "Pflegeregress : Ansturm Heime ?", "schwarze M\u00e4nner Team Sebastian", "Architektur : \" Radikale \" Bauten querkraft", "Architektur tanzen", "Ostasiens \" Denken Raum \" \u2013   Architektur Akupunktur", "Handel : KURIER-Magazin \" Architektur \"", "Spuren Kaiserin : \" Sissi \" Meran erfand", "Natur pur", "Meran : Alpen-Charme Dolce Vita", "Wiens gr\u00f6\u00dfte Skulptur", "Architekturtage 2016 : Baukultur Angreifen", "Wiener Weihnachtsm\u00e4rkte : Gl\u00fchwein kostet Durchschnitt 3,70 Euro", "FP\u00d6 : Direkte Demokratie Verbot politischen Islam", "Gr\u00fcnde Salzburger Erfolg", "17 . Juli 1914 : politische Lage spitzt", "Sales-Team kurier.at", "\" Gr\u00f6\u00dfte Steuerreform \" US-Geschichte geplant", "Salz & Pfeffer : Mercado", "Salz & Pfeffer : Gozzo", "Salz & Pfeffer : Fritz", "Salz & Pfeffer : FERDINAND", "Salz & Pfeffer : Koinonia Plus", "Salz & Pfeffer : V\u00f6llerei", "Salz & Pfeffer : La Pergola", "Salz & Pfeffer : EISVOGEL", "Salz & Pfeffer : Stiar", "Restaurants : Wien : Burger", "Nationalfeiertag : Feierlichkeiten Heldenplatz", "Bilder : Frau Depression besiegte", "Stra\u00dfe Werkstatt", "Haus wert ?", "Gregor Seberg : \" eigentlich faule Sau \"", "Video zeigt Streit Kinder Jugendamt", "Gemeindebau : Gutverdiener Miete zahlen", "Vergewaltigung : Robinho Haft verurteilt", "Restaurants : Brieftaubenkobel poppt Wien", "Fu\u00dfball : Salzburg Bundesliga Rekordkurs", "Dubai Panama : Emirates fliegt l\u00e4ngsten Nonstop-Flug Welt", "\" Titanic\"-Wrack Bakterien zerfressen", "Privatsph\u00e4re Garten", "\" Duterte Leben gerettet \"", "\" Schm\u00e4hf\u00fchren \"", "Austausch morschen Au\u00dfenfenster zust\u00e4ndig ?", "Courtney Love warnte 2005 Harvey Weinstein", "Wertvolle Sch\u00e4tze", "Prozess Grasser&Co Monate verz\u00f6gern", "Linda Evans : Ruhm & Geld machten gl\u00fccklich", "Charles Aznavour : \" Aufh\u00f6ren Sterben . bereit ! \"", "Tanztheaterst\u00fcck Jugendlicher : Hoffnung \u00c4ngste-Sch\u00fcrer", "AHS-\u00dcbertritte : Kinder polnischer M\u00fctter voran", "Augapfel-T\u00e4towierung : Model Catt Gallinger bangt Augenlicht", "Referendum T\u00fcrkei : Entscheidung Bosporus", "Gigi Hadid : Kleid peinlichen Stolperfalle", "NHL : Vanek Grabner siegen , Raffl trifft", "Bratislava : Smartphone Plastikgeld", "C\u00e9cile Nordegg : Mama haut Putz", "Abgesagt : Lena Meyer-Landrut Krise", "Debatte Zusatzgehalt : Christian Kern ortet \" Intrige \"", "FP\u00d6 Burschenschaften : national Nationalrat", "\" Problemwolf \" lie\u00df Heugabeln verjagen", "Liga : Liefering feiert Kantersieg", "Gault&Millau 2018 : Restaurants Bundesland", "Lena Meyer-Landrut ordentlich Kohle", "Wiener Linien : H\u00f6here Ticketpreise Anfang 2018", "\" Old Shatterhand \"", "Konzentrationsst\u00f6rungen : verursacht & hilft", "Blutproben vertauscht", "Rape Culture : \" M\u00e4nner Privilegien bewusst \"", "Simone Garcia Johnson startet : Vater Hollywoodstar", "Lieferservice Brotkost liefern Fr\u00fchst\u00fcck Hause", "Amira Willighagen : 11-J\u00e4hrige singt engelsgleich Arien", "Kern : \" Entscheidung flotten Sagern Plan \u00d6sterreich \"", "Trump begnadigte Truthahn : Seitenhieb Obama", "Winterblues : Gl\u00fccksgef\u00fchle essen ?", "Charlene : Zwillingen Sympathienfang", "vegane Imperium Karl Schillinger", "16 . Juli 1914 : Sozialisten bem\u00fchen Frieden", "Rapid Extra-Millionen Gewinn verspielt", "\u00d6VP liegt vorne , Rot Blau holen", "Bilder KURIER-Tag 2017", "Bonit\u00e4t pr\u00fcfen : Neuer Online-Rechner KMUs", "\" Caf\u00e9 de Paris \" Gef\u00e4ngnis sorgt Unmut", "SP\u00d6-interner Wahlkampf-Auftakt vertauschten Rollen", "Weihnachtsgeschenke : Typologie", "\u00d6sterreicher Sebastian wissen", "T\u00fcrkis-blaue Regierung : Leuchtturm-Projekte dringend gesucht", "Leichensuchhunde W\u00e4ldern Stiwoll", "Ferrero-Waldner schreibt Buch \" Benita \" \" EU-Sanktionen \"", "Vassilakou bietet Soros-Uni Quartier Wien", "Kate Beckinsale Harvey Weinstein : \" Wusste , missbraucht \"", "Sonntagsfragen : Phillip Hochmair", "Wolf vs. Prantner : Taktische Feuer ORF", "Frauen verbreiten Vorher-Nachher-Fotos Ex-Freund Netz", "Polit-Nachwuchs Hause Petrik", "Jungbauernkalender : Crossfit Bauernhof", "Genmutation verl\u00e4ngert Leben Amish", "Grazer Karlau verwandelte \" Keller \" Begegnungszone Insassen", "Cathy Lugner zieht slowakischen Playboy", "Rekord Gage : Ben Teewag \" Promi Big Brother \" ?", "Victoria Beckham Mode-Tipps 2 Dollar", "Spuren Schrittmacherin", "Sacher Selbermachen : Neues Backbuch Traditionshotel", "Verbindung weiblichen Sexualhormonen Lungenkrebs gekl\u00e4rt", "Geldw\u00e4schenetzwerk : Schwarze Rubel \u00d6sterreich", "Piercings Folgen : Experten warnen Body-Modifying", "Salzburg-Trainer Rose personell Qual Wahl", "passt blassen Haut", "Buben englischen Oberschicht tragen Geburtstag Shorts", "Bali : Tausende flohen drohendem Vulkanausbruch", "IOC sperrt erneut russische Medaillengewinner", "Fu\u00dfball , Champions League : Spieltag Weichenstellungen", "Gesundheitstalk : Brustkrebs zielgenau therapieren", "Strom Daten bezahlen ?", "Heidi Strobl : K\u00fcrbiscurry Art Reis", "RSS   - KURIER.at", "Sch\u00fcsse Grenze S\u00fcdkorea : UNO berichtet Grenzverletzung Nordkorea", "Snowboard : Big-Air-Dominatorin Gasser siegt Peking", "6 Tipps perfekten Shoppingtag", "Video : Victoria Beckham zeigt 5 Minuten-Makeup", "Nutellagate : Risikofaktor Palm\u00f6l - steckt", "George & Amal Clooney beneiden Cindy Crawford \" normale Kids \"", "London : Zwischenfall U-Bahn-Station Oxford Circus", "Philharmoniker-Klarinettist Ernst Ottensamer gestorben", "Meer Musik : Kreuzfahrt Mittelmeer Philharmonikern", "Air-Berlin-Chef : Gro\u00dfaktion\u00e4r Etihad 2016 aussteigen", "Diabetes", "Influenza : Zahl Erkrankungen nimmt deutlich", "Jamaika-Sondierungen stocken", "Naddel : bergauf ?", "\" Everest Lebenseinstellung ge\u00e4ndert \u201c", "\" dachte , Tod \u201c", "  Norman Dyhrenfurth : \" vergessen \"", "Ungew\u00f6hnliche Spuren Schnee", "Disziplinarverfahren : Wiener Arzt behandelt Asylwerber", "Saudi-Arabien : Frauen Autofahren", "Schuh : \" nationale Egoismus vieles zerst\u00f6ren \"", "Herbert Kickl : \" Mal General , mal Sekret\u00e4r \"", "KAV : Vertrag Direktor Balazs verl\u00e4ngert", "Millionen \u00d6sterreicher 2021", "\u00d6VP & FP\u00d6 : Rauchverbot , bitte warten", "Freispruch : Arzt-Kinder schildern \" H\u00f6lle Erden \"", "\u00d6VP : Sebastian Minister-Chancen", "wichtigsten Punkte Wahlprogramm Liste Pilz", "Anschlag \u00c4gypten : Ermittler IS Visier", "FP\u00d6 schn\u00fcrt hartes Forderungspaket", "Niqab-Aktivistin provozierte Wien", "Wissenschaft : Bio Welt ern\u00e4hren", "bedeutet ordentliche Verwaltung ?", "Dagmar Koller gesteht Aff\u00e4re Ehe Helmut Zilk", "XXL er\u00f6ffnet Stores , Sports Direct speckt", "Nina Janousek : bekannteste Wiener Puffmutter Interview", "Mister Miss Styria-Ladies", "Land Vormarsch", "FIFA Awards : Cristiano Ronaldo hochschwangerer Freundin", "Koalitionspoker : \" SP\u00d6 versuchen , verhindern \"", "Gr\u00f6\u00dfte Remise Wien : Nachtschicht Tramway", "Kochbuch : Johanna Maier : Gesunde K\u00fcche : Johanna Maier erfindet neu", "Trinkender Donald Trump verbreitet viral", "Helmut Bielers letzte Budgetrede : \" reif \u00c4ra \"", "Ostdeutschland : \" Reichsb\u00fcrger \" verletzte Polizisten schwer", "Amal Clooney : Kilofrust Geburt", "Beauty-Eingriffe : Brigitte Macron lassen ?", "Risiko Ertrag Depots optimieren", "Star Woche :   EBOW", "Ansturm F\u00f6rderung : 240 Antr\u00e4ge", "Heidi Strobl : Linzer T\u00f6rtchen", "\" Bargeld gem\u00fcnzte Freiheit ,   Abschaffung risikoreich \"", "TK Maxx er\u00f6ffnet Filiale Wien", "wettbewerbsf\u00e4hig \u00d6sterreich", "American Football : Tryout \u00d6sterreich 25 . September", "\" Dave   Gl\u00fcckstreffer \"", "Vanillekipferl Andrea Posch", "Angelina Jolie : Maskenhaft Autogrammstunde", "Ernst Molden , Wien Mitte : Nix Ziesel", "st\u00fcrzte Silberstein SP\u00d6 Wahl-Desaster", "\" h\u00e4tt \u2019 i g \u2019 wusst \" : Hitziges Gefecht ORF", "K\u00e4rnten : M\u00e4nnliche Leiche Brandruine entdeckt", "Oktoberfest : Tiroler Blaskapellen spielen Nazi-Marsch", "Champions League : Real verliert Tottenham", "stylt Sneakers B\u00fcro-Outfit", "365 + : 127 Tote Paris , z\u00e4hlt Physik ? !", "Fu\u00dfball-Bundesliga : St. P\u00f6lten 0:3 Altach 20 Spiele sieglos", "Kr\u00e4tzn Klugschei\u00dfer", "Salz & Pfeffer : Restaurant Lukas", "Breite Front Rauchverbot", "Secret Veneers : g\u00fcnstigere Alternative Veneers", "sieht Wiener Restaurant Jamie Oliver", "Glyphosat : EU-Parlament Zulassung 2022", "Haftstrafen Brandanschlag Fl\u00fcchtlingsunterkunft Altena", "Mandl : \" Ohren gekommen \"", "35-Stunden-Woche : k\u00fcrzer arbeiten bringt", "Studiengeb\u00fchren : Befreiung Berufst\u00e4tige l\u00e4uft", "# MeineStadt : Handylos", "Online-Matchmaking : Liebe bleibt unberechenbar", "# MeineStadt : Treffpunkt Bahnsteig", "Tinder-Tipps : hohe Kunst Online-Flirts", "Singles : Erf\u00fcllt , zufrieden - alleine", "Strenge Plakat-Fristen \" k\u00fcrzesten Wahlkampf \"", "Schwere Folgen Bel\u00e4stigungen sozialen Medien", "Cristiano Ronaldo : schwangere Freundin betrogen ?", "Clever shoppen : vermeiden Fehlk\u00e4ufe", "Klosp\u00fclung \u00d6sterreich meisten kostet", "Charlie Sheen Set 13-j\u00e4hrigen Corey Haim vergewaltigt", "Extremdi\u00e4ten & Aff\u00e4ren : Linda Thompson packt Elvis Presley", "Bundesliga : Rapid gewinnt 323 . Wiener Derby 1:0", "Schieder vs. Ludwig : bessere Linke ?", "Offiziell ledig : Katze verheiratet ?", "Kalorien : Onlinerezepte beliebt , ungesund", "Donhauser bewirbt Catering \u00d6BB AUA", "Toter Fl\u00fcchtlingsbub : Beh\u00f6rde \" Gef\u00e4hrdungslage \"", "K\u00fcssen Frauen : Fluggesellschaft zensiert Filmdrama Carol", "Andr\u00e9 Heller : \" \u2005 Leben \"", "FREIZEIT goes Online !", "KURIER-Gespr\u00e4che : gelingt Integration", "Hotel- Ferienclub-Pleite : 15.300 Investoren bangen fast 58 Millionen Euro", "wichtigsten Punkte SP\u00d6-Wahlprogramm", "Metaller-Lohnrunde : Latte liegt deutlich Prozent", "Fendrich-Musical : Windb\u00e4ckerei Wiener Schm\u00e4h", "Thomas Glavinic : \" Linke halten moralische Wahrheitsbesitzer \"", "dran Heimatschutz & Co. ?", "Banane : ges\u00fcnder - gr\u00fcn gelb ?", "Umfrage : schie\u00dft \u00d6sterreich EM-Achtelfinale ?", "Paris Hilton Harvey Weinstein massiv bel\u00e4stigt", "Faymann Reisef\u00fchrer Lehrlinge Br\u00fcssel", "Macron Debatte Alter Frau", "\u2019 Reformversprechen wackelt , Widerstand Josef Moser", "Herbert Stepic : \" Urwald Dreck \"", "treibt Straches FP\u00d6 , Frau Steger ?", "Haarentfernung : Waxing schmerzhaft", "Wien : Mariahilfer Stra\u00dfe : Zahlt Besuch TK Maxx ?", "Brad Pitt Ehe Jolie : \" 12 H\u00f6lle \"", "Restaurant Trattoria Pulcinella Naschmarkt : Hauchd\u00fcnn Pizza", "Logik , Mathe , Allgemeinwissen", "Youth on the run : Junge schl\u00fcpfen Rolle Fl\u00fcchtlingen", "\" Fr\u00fchst\u00fcck Tiffany \" : Neues Caf\u00e9 New York erweckt Sehns\u00fcchte", "VfGH ber\u00e4t \" Ehe \" Mindestsicherung", "Johann Lafer : Pizza Haubenkoch", "Weihnachten : Geschenke ?", "Christbaum Melania Barron Trump", "Roter Ex-Landesrat Rezar Krages-Chef Schnedl auszusetzen", "Bildungsexperten", "Kindergartenstudie : Uni Wien pr\u00e4sentiert Pr\u00fcfergebnis", "Wirtschaftskammer-Obmann fordert   Verbot Gewerkschaften", "\u00d6FB-Team : \" Niveau \"", "Brigitte Macron : Premiere Dame wussten", "Donald Trump tragen", "Shakira : Mode-Fauxpas Messi-Hochzeit", "Rock Arbeit : Franz\u00f6sische Busfahrer pfeifen Dresscode", "Wolfgang Sch\u00fcssel : Espadrilles Parlament", "Angela Merkels Look : Blazer besondere Halskette", "Niger : Afrikas Drehscheibe Fl\u00fcchtlingskrise", "Jennifer Garner : \" Leben vorgestellt \"", "Schuhe Wieners Markus Scheer geh\u00f6ren teuersten Welt", "Weltmuseum", "Unglaubliches \" Kulturerbe \"", "Jennie Garth : Ehe steht", "# Stadt : Einfach zuh\u00f6ren", "Herzkrankheiten : fr\u00fche Diagnose per Handy", "Trendige Must-Haves 2017", "\" Total geschw\u00e4cht \" : \" Naddel \" Nadja Abd el Farrag Unfall", "\" Times Higher Education World Reputation Ranking \" : heimische Uni Top 100", "Interview : Soziologin Ingelore Ebberfeld versexte Gesellschaft", "2 . \u00d6sterreichischer Jugendpreis : ( Frei-)R\u00e4ume Jugendliche Jugend-Begegnungen", "Wirtschaftsmotor Internet \u00d6sterreich", "Florian Holzer : Top 5 : Essen Bahnhof", ": Highlights entlang Rhone", "Saudi-Arabien : Frauen Sportstadien -", "Thomas Maurer : \" lautes Nachdenken \"", "Portugal : sch\u00f6nsten Str\u00e4nde H\u00e4user Algarve", "Italien : H\u00e4f \u2019 n-Restaurant gef\u00e4llt G\u00e4sten", "\" T\u00e4glich verschwinden Kinder \"", "Superreiche Italiens klamme Staatskasse auff\u00fcllen", "Italien : Eltern Kind \" alt narzisstisch \"", "Hamon , Schulz , Corbyn , Renzi : Europas Linke Krise", "Mafiosi bedienten   Richter   Turin Bar Justiz", "Auslieferung mutma\u00dflichen Serienm\u00f6rders gestoppt", "Landwirt Hof Schenkung Aiderbichl", "Privilegien-Kaiser Krankenbettes", "Weltmuseum Kristallwelten : heller", "Meghan Markle : Kates Freundschaft buhlt", "Gans bek\u00f6mmlich : Tricks K\u00f6che", "Wanderwege Toren Wiens", "Schwammerl : Geheimnis perfekten Parasols", "69-Millionenpleite Hotel-Ferienclub-Gruppe", "Zentralmatura : Themen Fach Deutsch", "Nicholas Ofczarek : \" Fassade g\u00e4hnt Abgrund \"", "Leitartikel : Putsch funktioniert", "Anna Ternheim : Trauermarsch High Heels", "Wiener Stadtwerke : Umwandlung GmbH", "26 . Juli 1914 : \u201e unvermeidliche \u201c Krieg allerhand   Ablenkungsman\u00f6ver", "\u201e Langsam ungeduldig \u201c", "Deutsche lie\u00dfen \" Gria\u00df di \" patentieren", "Suche Flugzeug Sonar Roboter", "Neues Restaurant It 's all about the meat baby : Gourmet-Burger Hotdogs Charlie P 's", "Schlaf , !", "Graz-Salzburg ( retour )", "Medizinballgro\u00df ( II )", "wunderbar unwichtig", "Genussvoll traurig : Song-Contest-Protokoll", "Danke , Netz !", "Zahl E-Autos 2016 weltweit verdoppelt", "NR neu : Christliche Hardliner Burschenschafter", "Zuwanderung : Rot-Wei\u00df-Rot-Karte floppt", "Razzia   Hausverwaltung", "Koalitionsvereinbarung : Steuerentlastung geplant", "Schieflage : UEFA nimmt AC Milan Visier", "\" , ? \"", "' Bewegung \" Z\u00fcge Panikreaktion \"", "Wiener Kulturbudget : Zukunft rosig", "Bundesheer-Uniformen Fleckenmuster", "Mordprozess Kopfschuss : Wahrspruch ausgesetzt , Urteil", "Prozess Kopfschuss J\u00e4gerstra\u00dfe : \" \"", "Ohrwaschl : zufrieden", "Hausverwaltung ?", "\u00d6BB-Catering : Henry \u2005 Zug bleiben", "\u00d6sterreich Israel gewonnen", "Elijah Wood : \" Hollywood voll Kindersch\u00e4ndern \"", "Studie : Beauty-Merkmal l\u00e4sst kompetent wirken", "  \" Elvis Entertainer \"", "JVP-Chef : Sebastian tritt", "Vanillekipferl Muck-Oma", "Simbabwe : Robert Mugabe zur\u00fcckgetreten", "Katie Price : Mann gesteht Aff\u00e4re Nanny", "Arnies wildeste Aff\u00e4ren : 70 . Geburtstag Arnold Schwarzenegger", "Roberto Blanco gesteht Aff\u00e4ren unz\u00e4hligen Frauen", "Prinz Charles weinte Hochzeit Diana", "Bruder Kate Hudson spricht Brad Pitt-Aff\u00e4re", "Sarah Lombardi : Kussbilder Aff\u00e4re", "Michele Binswangers Buch Fremdgehen : Frauen Seitensprung treibt", "Lady Di : Umstrittene TV-Doku royales Sexleben publik : Diana : own words", "Camilla packt Aff\u00e4re Prinz Charles", "Camilla Charles Wien : Stil-Check", "Royale Visite : Charles Camilla \u00d6sterreich", "Camilla zitternden H\u00e4nden \" Hello \"", "sp\u00e4tes Happy End Camilla & Charles", "40-J\u00e4hriger st\u00fcrzte Pkw Wienfluss-Trasse", "Derby-Wahnsinn : Schalke 0:4 4:4", "Computer-Nachhilfe Pensionisten", "Fu\u00dfball : FIFA-Skandal : Auto-Spitznamen illegalen Zahlungen", "China verweigert Victoria 's Secret-Models Visum", "K\u00f6rper manchmal einzelne H\u00e4rchen sprie\u00dfen", "\" 100 Ziel erreicht \"", "Merkel Neuwahl geplatzten Koalitionsgespr\u00e4chen", "enge Mitarbeiter Sebastian bekommen Botschafterposten", "Neuer FP\u00d6-Bundesrat posierte Jugendfoto \" Hitlergru\u00df \"", "Vegane Anker-Filiale poppt", "Herbst-Looks : 3 Arten , Stiefeletten cool stylen", "Frauen", "Pensionisten & Fl\u00fcchtlinge : bekommt ?", "Vorw\u00fcrfe Frederik & Mary : Arbeitsscheue D\u00e4nen-Royals ?", "steht Brangelina-Scheidung", "\" Falcon Crest\"-Stars", "Aufgaben Mathematikmatura 2017", "Rauchverbot : \" Halten Verbotskultur \"", "Gudenus Markovi\u0107 : T\u00e4nzchen Serbenfreund", "Notfall Krankenhaus Nord : Planer heillos \u00fcberfordert", "Weizenkeimlingen Kaffee : vorbeugend Parkinson hilft", "Fr\u00fchstadium : N\u00e4hrstoff-Kombi bremst Alzheimer", "Lilly Becker : steht Ehe Boris", "Krankheit Million\u00e4rin : Karriere Judith Williams H\u00f6hle L\u00f6wen", "Missbrauchsskandal : \u00d6SV beschlie\u00dft Ma\u00dfnahmenpaket", "F\u00e4lle : Mehrere Gr\u00fcne Frauen contra Pilz", "Texas : Gro\u00dfspurig , gro\u00dfherzig gelassen", "Schwache Mehrheiten , schwache Koalitionen", "Ein- Ausbr\u00fcche", "Alexander Kumptner \" Grill Profi \" : \" Rotlicht H\u00f6lle \"", "Restaurants : Wien : 10 Restaurants er\u00f6ffnet", "Ungar raubte Tankstellen erschoss", "Heer setzt Schutz Hilfe Inland", "Grammeln , Kutteln", "Eva Menasse gewann Raupe , Ente , Opossum", "Bestattung", "Asterix Testus Sterone Chance", "Prinz Harry : Datet heimlich Ellie Goulding ?", "Peter Pilz : \" Frau l\u00e4nger zumuten \"", "Weltnudeltag : Nudeln K\u00f6rper bewirken", "K\u00fcndigung Facebook-Video Arbeitskleidung", "\" Twilight\"-Star Kellan Lutz geheiratet", "  KURIER-Gespr\u00e4ch 5 . Dezember 2017 | 18", "Salz & Pfeffer : Elissar", "H\u00e4upl-Nachfolge : \" Schaukampf geben \"", "Muslimische Eltern Beschneidung Vorarlberg verurteilt", "Mutma\u00dflicher Sechsfachm\u00f6rder Aslan G. Wien erneut festgenommen", "Spielregeln 24-Stunden-Pflege", "Infografik : effektiv einfach Garderobe ausmisten", "US-Deal : Hunderte IS-K\u00e4mpfer Raqqa fliehen", "Campino & Minichmayr : Heimliches Paar getrennt ?", "10 Kr\u00e4utertees K\u00f6rper wirken", "Busenblitzer & deutsche Promis Filmball", "Bryan Cranston unheimliche Begegnung Charles Manson", "Analyse Nationalratswahl 2017 : T\u00fcrkis-Blau , eigentlich ?", "F\u00eate Imp\u00e9riale : Hoffen Wettergott", "Prinzessin Anne Spanischer Hofreitschule ausgezeichnet", "Hofreitschule : Bereiterin Lipizzaner angelobt", "Hannah wei\u00dfen Pferde", "Sex Globus", "Blamage Basher Beschwichtiger", "Monaco-Zwillinge : tabu", "Handel : KURIER-Magazin \" Schmerz \"", "Fr\u00fchst\u00fcck Gregor Seberg", "Koalitionsverhandler starten \" Phase \"", "Polizei : Rekrutierungsoffensive schlechter Bewerber", "Kaczy\u0144skis Katzen-Buch versteigert", "OMV-Aktien b\u00fc\u00dfen Zahlen 3,3 Prozent", "Mila Kunis : Wieso 3-j\u00e4hriger Tochter Alkohol Trinken", "Bali , Hotspot digitale Nomaden", "\" , demonstrieren \"", "\u00d6VP-Kandidatin stellt US-Aktivistin Davis", "Kasperl Diktator st\u00fcrzt", "Helfer Fl\u00fcchtlinge : \" Politiker Freiwilligen nehmen \"", "SP\u00d6 besetzt \" Rote Telefon \"", "Weihnachtskekse : Spekulatiusgew\u00fcrz , selbstgemacht", "Gr\u00fcne feiern \u00d6sterreich Erfolg Glyphosat", "Freundin : Jonas Kaufmann Liebesgl\u00fcck", "G\u00e4nserndorf S\u00fcd : wunderbaren Verlierer", "Politik Kunst schlauen Personalspiels", "Stellenabbau Pharmakonzern Shire : Bittere Pille 650 Mitarbeiter", "Rolex , Villa , SUV : Richter zittern", "Sport & Bildung : Ex-Profis pl\u00e4dieren Plan B", "SPD Regieren verdammt ? Schulz Mitglieder befragen", "Satire : Scherenschnitte helfen nix", "Sportpolitik : Assingers Wutrede : \" Infrastruktur Sport Sau ! \"", "Restaurants : Hannah 's Speisesaal er\u00f6ffnet", "Fast Franz\u00f6sin befolgt Shopping-Regel", "M\u00e4ngel dokumentieren Streit vermeiden", "Nachfolger gesucht : Koller Abgang", "Guthaben Nachzahlung ?", "L\u00e4rm ?", "Lift zustimmen ?", "Wohntelefon : Rauchen verbieten ?", "... manchmal weint \" , 2", "Googeln Lehrer", "Isabella Radich : Leben Zucker", "Palm\u00f6l : Konsumenten-Anfragen gestiegen", "Ghanem : Fremdverschulden", "Heikle Personalfragen ORF", "ORF-Betriebsratslegende Heinz Fiedler 72-j\u00e4hrig verstorben", "ORF-Zentralbetriebsrat stimmt neuem Kollektivvertrag", "K\u00fcniglberg-Kultur", "Kaufhausdetektiv griff Austrot\u00fcrkinnen", "Wohnungen City : Trotz 12.600 Euro/m2 gefragt", "Weihnachten : Einsamer Pensionist sucht Gesellschaft", "Weihnachten Belastung", "Tod elfj\u00e4hrigen Fl\u00fcchtlings N\u00d6 : Beh\u00f6rden stehen Kritik", "  OECD-Studie : Bildung bringt Geld Staat", "Trump-Skizze fast 7.000 Dollar versteigert", "39 Gef\u00e4ngnis H\u00e4ftling freikommen", "Extrem straff : Brigitte Macron lassen ?", "Soldaten Grundausbildung Bundesheer", "Haubenkoch droht Lokalverbot", "S\u00f6lden Tunnel Dorf", "\" Concession Speech \" : Rede Hillary Clinton Niederlage", "Graumarkt : Gesch\u00e4ft g\u00fcnstigeren Luxusuhren", "Junuzovic l\u00e4sst Zukunft Werder", "Dach : funktioniert Wohngemeinschaft", "Gericht : geschlagen ?", "k\u00fcmmert Erhaltung Kleingartenanlage ?", "Projekt Eigentum Erfolg", "Auto abstellen Geld verdienen", "H\u00e4user brauchen Ausweis", "Nationalrat : FP\u00d6 meisten Topverdiener", "Tabu-Thema Fehlgeburt : Promis Melissa Rauch sprechen", "Alkohol Nikotin : \u00d6sterreich deutlich OECD-Durchschnitt", "Regierungsverhandlungen : FP\u00d6 Budget Bundesheers Drittel aufstocken", "Georg Kreisler 89-j\u00e4hrig gestorben", "Neues Restaurant : Wlaschek-Enkelin er\u00f6ffnet Spelunke Donaukanal", "Inklusion : Kino ( fast )", "Lebensversicherungen : Kunden Pr\u00e4mien samt Prozent zur\u00fcckfordern", "\u00d6VP FP\u00d6 L\u00e4nder \" Mindestsicherung light \" zwingen ?", "Steffi Graf spricht Deutsch", "Jennifer Lawrence : Nacktfoto-Klau \" unfassbar verletzend \"", "FP\u00d6-Ticket : Nahostexpertin Karin Kneissl Au\u00dfenministerin", "Ablehnung \" Ministern \" : Inszenierung", "Hurts : Bett Sharon Stone , Prince & Depressionen", "Michelle Hunziker trennte Sekte Eros Ramazotti", "Gault&Millau 2018 : beste Sekt \u00d6sterreichs Ebner-Ebenauer", "Indien : Tote Aufst\u00e4nden Haft Star-Guru", "Frisuren \u00d6sterreicher lieben", "Alfons Haider 60 : \" Feinde \" \" Krise \"", "Stra\u00dfenstrich Brunner Stra\u00dfe Wien-Liesing : \u201e Zuh\u00e4lter Nachbarn \u201c", "Pippa : Teure Umbauarbeiten erz\u00fcrnen Nachbarn", "Ski-Zirkus nimmt Abschied David Poisson", "Venezuela : EU erh\u00f6ht Druck fordert freie Wahlen", ", vorbei : allerletzten Autos Down Under", "Abschiebungen : 67 Afghanen", "94-J\u00e4hrige feiert Geburtstag Fallschirmsprung", "Haag bestellt Schicklgruber , Drozda am\u00fcsiert", "Lake Louise : Veith freut Weltcup-Comeback", "Welfen-Hochzeit : Casiraghis feierten Brauhaus", "Cartellverband : Br\u00fcder verloren", "Vorbildlich : Fl\u00fcchtlinge schnell Deutsch lernen", "Rex-Darsteller Clinch B\u00fcrgermeistersohn", "Parlamentarische Anfrage : Vergewaltigungen Asylwerber gestiegen", "Zeitplan NR-Wahl : \u00d6sterreich Regierung ?", "Bilanz - Bierkonsum \u00d6sterreich : \u00d6sterreicher trinkt 215 Kr\u00fcgel pro", "royale Regel pfeift Herzogin Kate", "Dianas Bodyguard : \" William schwieriges Kind \"", "Erziehung : Prinzessin Diana \u00c4rger Nanny", "FP\u00d6-Medienverhandler schimpft : \" Linker Agitprop \" ORF", "Marcel Hirscher Levi Weltcup-Comeback", "Medizin-Mythen : Hilft MSM Arthrose ?", "Kult-Bar : Madame Ninas langer   Kampf     Abriss", "EBEL : 4:3 Linz - Capitals gewinnen Schlager ziehen", "Serena Williams : Mutter \" echte Frau \" ?", "Lebensqualit\u00e4t Diabetes bekommen", "Nationalrat : Mietvertragsgeb\u00fchr abgeschafft", "Schwarz-Blau I begann unterirdisch - R\u00fcckblick", "Selfie postfaktisch : Duden enth\u00e4lt 5.000 W\u00f6rter", "Szenenfotos : \" Liebe \" Josefstadt", "Sozialversicherung : Selbsterhaltungsk\u00f6rper", "\u00d6FB-Teamchef Marcel Koller : \" beklagen , Leute freuen \"", "Metallbau-Pleite Ober\u00f6sterreich : 238 Mitarbeiter betroffen", "\" wichtigste Start-up-Stadt \"", "Victoria 's Secret Show 2017 : l\u00e4uft Kendall Jenner ?", "\u00d6sterreichs Unter-21-Auswahl Mazedonien Sieg Pflicht", "VIG-Kids-Camps : Bunte H\u00e4nde Friedenszeichen", "Mazedonien : Zaev erwartet Auftrag Regierungsbildung", "Mazedonie : Gro\u00dfdemo St\u00e4rkung Albaner", "Restaurants : Wien : Asiaten Wien", "Queen + Adam Lambert : Nostalgischer Spa\u00df", "\" Kurz-Effekt \" verj\u00fcngt Nationalrat", "Nepal : \u00d6sterreicher mutma\u00dflicher Kindersch\u00e4nder festgenommen", "Frage Titels : letzten Magister", "Wiener Stadtwerke : Beamte 28 pro krank", "Johnny Depp : Bilder Dior-Kampagne Eau Sauvage", "\" La Traviata \" Mail\u00e4nder Scala : Verirrungen", "Studie : Kinder engere Bindung Haustieren Geschwistern", "Stanford-Studie : Kiffer Sex", "12 Monate Haft Immobilien-Investor Benko", "Kate Winslet , George Clooney , Meryl Streep & Co : Harvey Weinstein sagen", "EU-Prognose : Arbeitslosigkeit \u00d6sterreich steigt 2018 6,2 Prozent", "Shooting Girls : J\u00fcdische Fotografinnen Wien", "Beliebte Babynamen : Anna Lukas erneut vorne", "NHL : Vanek schl\u00e4gt Raffl \u00d6sterreicher-Duell", "Heimliche Hochzeit : Franziska , \" Weisz \"", "Kanelbulle verdr\u00e4ngt \u00f6sterreichische Zimtschnecke", "Ex-Teamkeeper Br\u00fcckler : \" Arbeit Aubin sensationell \"", "Trotz Betretungsverbots : Mann t\u00f6tet Frau Kinder", "Flucht Syrien : Guardian-Video zeigt Ranias Odyssee Wien", "Arzt   Adelsmayr unterst\u00fctzt angeklagten Kollegen S\u00fcdafrika", "Kern : Europa sch\u00fctzen , scheitert", "22 . Juli 1914 : \u201e Kl\u00f6ppel Schlage ausgeholt \u201c", "27 . Juli 1914 : , Sch\u00fcsse fallen", "Zeitungs-Workshop : Minecraft lustigen Katzen", "Geld wert : \u00dcberbezahlte Stars Johnny Depp", "Wege Mozart-Gl\u00fcck", "modernste Opernb\u00fchne Welt", "\" N\u00e4hrboden Kunst \"", "Haus mieten : 10 Fragen Antworten", "Ludwig Scharinger   fast v\u00f6llig genesen \u201e Art Wiedergeburt \u201c", "Marlies & Benni Raich Mal Eltern : Sohn", "Karlheinz Hackl : \u201e Wort , K \u2018 lass weg \u201c", "\"   Unb\u00f6seste \"", "Netiquette", "\u00fcbergewichtig fettleibig", "30 Kilo Operationssaal abnehmen", "Schnellbahn-Z\u00fcge technischen Problemen", "Pleitegeier kreist Semmering", "Sekt : Gault&Millau : Sekte \u00d6sterreichs", "\u00d6VP FP\u00d6 pr\u00e4sentieren Ergebnisse Steuerungsgruppen", "Restaurants : Schnitzel Wien", "Expats-Umfrage : Wien weltweit unfreundlichste Stadt Paris", "Gault&Millau 2018 : Hauben-Restaurants \u00d6sterreich", "Marktforscher wissen ,   Zukunft bringt", "H\u00fclsenfr\u00fcchte waschen : beste Tipp Bl\u00e4hungen", "Prozess : Psychisch Kranker versuchte Oma Wien Kind wegzunehmen", "T\u00fcrkischer Pr\u00e4sident Erdogan Griechenland besuchen", "Schillers Streit Schuhe , Schnee Spendengeld", ": Bettina Assinger getrennt", "Douglas Beauty-Waggons Z\u00fcgen einrichten", "Krampusse Perchten Protestmarsch Klagenfurt", "Wiener SP\u00d6 : Ludwig wirbt Schreiben Genossen", "Vorbereitung : Maroni Wasser eingeweicht", "Missbrauchsopfer klagt Orden Schadenersatz", "Technik nervt", "Barfu\u00df Myanmar : sch\u00f6nsten Tempel Natursch\u00e4tze", "Redaktion Ober\u00f6sterreich", "Peter Schr\u00f6cksnadel : Machtbewusster \u00d6SV-Pr\u00e4sident Alpenk\u00f6nig", "Richard Kaufmann \u00fcbergibt Stefan Lechner", "Badende Vergewaltigung bedroht : T\u00e4ter gesucht", "Andrea Maria Dusl : Wiener Typen", "BDI baut Algenzuchtanlage Hartberg", "Aff\u00e4re Double : Abstruseste Ger\u00fcchte Melania Trump", "1.Mai-Geschichte : Kreisky dreht Grab", "Marz bleibt rote Problemzone", "Hausverwaltung Gehalt Hausbesorgers erh\u00f6hen ?", "Redaktion : IMMO-Magazin", "Tafelspitz : Wirtshaus-Guide - 350 Top-Adressen Beisl Brauwirtshaus", "Verh\u00e4ltnis Risiko Ertrag", "Audienz : Merkel bringt Papst Dulce de Leche", "Polizei ermittelt Fake News Vatikan - Papst Franziskus Visier anonymer Kritiker", "Papst Franziskus empfing Agnostiker Stephen Hawking", "Franziskus bedauert Ja-Wort ehemaligen Nonnen Italien", "500 Reformation : Papst Franziskus Schweden", "Harte Strafen Mobbing via Internet", "Offene Rechnungen : Pikanter Millionenstreit Luxusimmobilie Philipshaus", "Therapien fortgeschrittenem Brustkrebs", "Gem\u00fctliche W\u00e4rme : Kamin anbauen ?", "Kinder Hunde", "24-Stunden-Betreuung \u00f6sterreichischer", "Shangri-La Malediven : Luxus pur Indischen Ozean", ": \" ausgeben Verf\u00fcgung \"", "Rechtskr\u00e4ftig : Duzdar gewann Klage Strache", "Dankesch\u00f6n Lernhaus-Sponsoren", "Richter schickt Arzt Psychiater", "Schieder vs. Ludwig : Erbfolgestreit Wiener Rathaus", "Nacht Mittwoch k\u00e4lteste Herbstnacht : Frost Osten", "Impressum FREIZEIT", "\" Duschfehler \" l\u00e4sst Fu\u00dfpilz entstehen", "NEOS sehen Gr\u00fcnberg-Opel Fall \u00d6VP-Ethikrat", "Arbeiterkammer : Eltern Schulkosten zahlen", "\" Zwang Zusammenarbeit steigt \"", "Oliver Alexandra Kaminek Aussteiger bewirtschaften Bauernhof Stammersdorf", "Victoria Beckham entwirft Eva Longorias Hochzeitskleid", "Trump Mittelfinger gezeigt : Frau Spenden \u00fcbersch\u00fcttet", "Vienna Art Week", "Kurier digitalisiert Freizeit Magazin", "\" Helle N\u00e4chte \" : Vater Sohn Roadtrip Norwegen", "Wohlstand ,", "Punk Star-Koch", "Striedinger Chef Heeres-Abwehramtes", "Gener\u00e4le ihren Minister mobil", "Tyrannenkinder : Eltern trauen , Kinder erziehen", "Strache : \" reifer \"", "25 . Juli 1914 : \u2005 Frieden \u2005 h\u00e4ngt \u2005 \u2005 \u2005 d\u00fcnnen \u2005 Faden", "15 . Juli : Medien diskutieren Krieg Frieden", "WM-Play-off : \" Apokalypse \" : Italien WM-Aus Schockstarre", "George Soros : Spekulanten-Legende 85", "Wahl 2017 : Wahlbeteiligung", "Marlene Dietrich : Liebschaften letzten", "Kriechbaum : \" Anna wichtigste Rennl\u00e4uferin \"", "Dubiose Cyberw\u00e4hrung OneCoin Anleger Geld kosten", "Unabh\u00e4ngigkeitstag : feiern Amerikaner eigentlich 4.Juli ?", "Ski alpin : S\u00f6lden-Siegerin Rebensburg siegt , Brunner Killington", "Cannabis - freigeben ?", "Rapid Verl\u00e4ngerung : Auer Letzte", "Mord verj\u00e4hrt : Ungel\u00f6sten Verbrechen Spur", "Patricia Blanco : Eifersuchts-Attacke Nacktshow Adam sucht Eva", "erkennen , Avocado reif", "William Kate r\u00fcsten Sicherheitsvorkehrungen", "Ursula Strauss Schicksalsschl\u00e4ge", "FP\u00d6-Minister : Strache Kritik Van Bellen", "\u00d6SV-Pr\u00e4sident Peter Schr\u00f6cksnadel zeigt sch\u00f6nsten Pl\u00e4tze Fliegenfischer", "\u00d6SV-Pr\u00e4sident Peter Schr\u00f6cksnadel Interview : \" Irgendwann sitzen Curling \"", "Handel : KURIER-Magazin \" Ober\u00f6sterreich \"", "Richterin Grasser zust\u00e4ndig ?", "Oberlaa : U1 f\u00e4hrt Verl\u00e4ngerung", "Flucht-Drehscheibe Mailand : Tr\u00fcgerische Ruhe Tor Norden", "Playboy : Ines Rau Transgender-Playmate", "Weihnachtskekse : Spekulatius", "Wien : Lateinische Inschriften", "geh\u00f6ren \u201e \u201c Seen ?", "Wiener Schulen \u00fcberlegen Handyverbot", "Sch\u00fcler Mobbing betroffen", "Thomas Glavinic , FP\u00d6 \" Urhure \"", "Abseits Mainstreams", "Praterstra\u00dfe : Handyshops Szenelokalen", "Promis royalen Doppelg\u00e4ngern", "Killerdroge : Todesfall \u00d6sterreich", "Verena Schneider : Wetter-Ansagerin Talkshow-Star . Puls 4 Show \" Schneiders \"", "Freilassung Nordkorea : US-B\u00fcrger starb mysteri\u00f6se Weise", "KURIER Libanon : Bundesheer beginnt gef\u00e4hrlichste Mission", "Mobiler Info-Stand lockt Touristen unbekannte Ecken", "UN-Klimakonferenz Bonn : \u00d6sterreich Klima-Pranger", "Semmering : 17 Festnahmen Grandhotel", "Waffenh\u00e4ndler r\u00fcsten", "\" Human Flow \" Ai Weiwei", "Noten Schule h\u00e4ngen Leistung", "Sauberkeit Sozialstaat heben Sicherheitsgef\u00fchl", "eigentlich Schlagers\u00e4ngerin Nicole ?", "Waris Dirie l\u00e4sst H\u00fcllen fallen", "Medizin-Mythen : Basenwasser ?", "Z\u00e4hneputzen Mund aussp\u00fclen", "Liste Hohe Haus : Abgeordneter ?", "Schwarz-Blau : Architekten k\u00fcnftigen Koalition", "Trump Asienreise : \" Maximaler Druck \" Nordkorea", "Kern : FP\u00d6 \" \u00d6sterreich EU sprengen \"", "Deutsche Pkw-Maut : \u00d6sterreich klagt EuGH", "Geiselnahme Jugendamt Bayern", "Ex-Frau SPD-Politiker Lauterbach : \u201e Hoffentlich Minister ! \u201c", "The World 's 50 Best Restaurants : Top 10 Welt : Steirereck geschafft", "Cap sorgt Parlament Lacher \" Ich-Programm \"", "21 \u00dcberlebensregeln \" Zombieland \"", "15 Lassing : \" Gib \u2019 Buam \"", "Vergn\u00fcgungspark Kunst-Hipster", "Trenklers Tratsch : Husslein-Arco Grab geschaufelt ?", "Vanillekipferl Rosi Tant '", "Vanillekipferl Sabine Boandl", "Duft Tasse : Aufguss , bitte", "\" No sports ! \" stammt Winston Churchill", "Wolferl Ambros : \" heirate ! \"", "italienischen Lokale", "Restaurants : Wien : 12 Restaurants", "\" Donaukanaltreiben \" trotzt   Wetterkapriolen", "Leistbarer Luxus Alltag", "Schottland : Landstriche Bilderbuch", "Kunstwerke F\u00fc\u00dfe Kunst Haus Wien", "Maifeste : Architektur , Esel Feuerwerk", "Kunsthalle Wien : Wunder bleiben \u00e4u\u00dferst rar", "Sp\u00e4te Reue : Kevin Spacey outet schwul", "Laos & Kambodscha : R\u00e4tselhaftes Indochina", "Donald & Melania Trump : Getrennte Schlafzimmer", "\" Trump Angst Bild \"", "Egal , , Argwohn ernten", "Lob analogen Lebens", "Sarah Wiener : \" Kochen politisch \"", "Wine the City : Wein Sting trinken", "Verletzte Frau Silvester : Verfahren Polizei eingestellt", "La Carte 2018 : Restaurants \u00d6sterreichs", "Metaller-KV : Arbeitgeber fordern Runde Zur\u00fcckhaltung", "Restaurants : 8 Restaurants", "Heidi Klum : Mel B steht Trennung", "Stellenmarkt : echten Jobs", "Johanna Maiers Weihnachtsmen\u00fc", "Parlamentsumbau : Rohbau Ausweichquartiere Heldenplatz fertiggestellt", "Beste Freundin erstochen : Mord , Haft", "Markus Wallner : \" rote Linie Europa \"", "Modetrend 2017 : Paper Bag-Hosen -R\u00f6cke", "Christine Reiler \" \"", "Kosten Fl\u00fcchtlinge \u00d6sterreich Schnitt", "Bloggerinnen : seht ? Vicky Heiler , Caro Daur , NovaLanaLove", "25 170 Texten \" \"", "Andreas Salcher Freundschaft : \" Freunde wichtiger Geld Erfolg \"", "Herr Professor Sch\u00fcler", "Pflegeskandal : \" v\u00f6llig fassungslos \"", "Qu\u00e4lereien fotografiert ?", "Missbrauchsfall : Demo Stift", "Wiener Krankenhaus Nord 200 Millionen Euro teurer", "  ATV 's Gemeindebau : \" glaubw\u00fcrdig \"", "Reineke Rampenlicht : Vorl\u00e4ufer Fake News", "Suche : Anna geh\u00f6rt ?", "Bahncaterer Henry Zug : Gespr\u00e4che Gewerkschaft Do & Co-Chef Attila Dogudan", "wichtigsten Punkte \u00d6VP-Wahlprogramm", "Meilensteine Frauen \u00d6sterreich", "Causa Pilz : ?", "Vorwurf sexuellen Bel\u00e4stigung : Peter Pilz tritt", "Vorw\u00fcrfe : Joey Kelly rechnet Vater Dan Kelly", "N\u00fcsse : 5 Sorten gesund", "Christian Hannover : Carolines Stiefsohn heiratet Model", "Schwierige Verhandlungen Klima", "Wertpapierveranlagung : Risiko braucht Kontrolle", "Haimbuchner : \"   Schwarz-Rot   bleibt Alten \"", "OGH-Urteil : \" Rauchersheriff \" h\u00f6rt", "Europa League : Salzburg feiert \" tollen Erfolg \"", "Deutsche Bundesliga : Bayern siegt Spitzenspiel", "Kalt Schal ? Homepage Orientierung", "Letzter Wunsch erf\u00fcllt : Todkranke Britin Jo Phillips besuchte \u00d6sterreichs Alpen", "Investor Z\u00f6chling krallt Erne Group", "Josef Hader Berlinale : \" Wilde Maus \" erheitert Wettbewerb", "\" Internet Kinder Waffe \"", "KURIER eAbo Plus    - per Maus Zeitung", "kl\u00fcgsten Welt", "Wiener Apotheke Preisrebell", "Miete Altbau ?", "K\u00fcche , Bad M\u00f6bel : Wof\u00fcr \u2002 Abl\u00f6se verlangen ?", "\" Arrogant \" : Frank Rosin \" The Taste \" unbeliebt", "Kern : \" Chancen , zur\u00fcckzukehren \"", "Serien Games finden", "\" Problemwolf \" besuchte Bauernhof", "W\u00e4hler SP\u00d6-Streit entschieden", "Schuhe Karton aufbewahren ?", "Hollywood f\u00e4hrt chinesische ( Finanz-)Mauer", "Gestohlene Kindheit : Gewalt Sport", "Sexuelle Gewalt : Feind W\u00e4nden", "H\u00e4lfte \u00d6sterreicher Sportmuffel", "Harvey Weinstein : Trennung Ehefrau", "Mehlspeisen Restln", "Aufdeckerin Ulla Kramar-Schmid wechselt profil ZiB2", "\" Cannabis-L\u00fcge \" Psychiater Kurosch Yazdi : \" Kiffen harmlos . Cannabis Ei legen \"", "Caf\u00e9+Co entwickelt Markenauftritt", "Direktfl\u00fcge : St\u00e4dtetrip Hongkong , Macau Bangkok", "Kurier TV-News : Gudenus l\u00f6st Shitstorm Sch\u00fclerin", "KURIER-Lernhaus :   Kinder selbstbewusster , Leistungen", "Chance besseren Start Leben", "R\u00fcckschlag Hayden Panettiere : \" Nashville \" abgesetzt", "Wehrlos \" Ger\u00fcchtsurteil \"", "dunkle Seite Palm\u00f6l-Booms", "starb Werner Schwab", "Riesiges Hakenkreuz Hamburg entdeckt", "Buchh\u00e4ndler Walter Kettner alte Floridsdorf", "Pferd sterbender Frau Krankenhaus geholt", "US-Superm\u00e4rkte scharf Teslas Elektro-Lkw", "Skeleton : IOC sperrt Russen lebensl\u00e4nglich", "Kraft Qualifikation Weiteste", "Buben bessere Noten , M\u00e4dchen Klassen", "Body Shaming : Frauen K\u00f6rperkritik stark", "Bitcoin : Regulierungsl\u00fccke zieht Gr\u00fcnder \u00d6sterreich", "\" Vergleichbarkeit \"", "Bitcoin-Boom : Spurensuche Wien", "Digitalw\u00e4hrung Bitcoin steigt neues Rekordhoch", "Kuss Demi Moore \" unsittlich \" ?", "James Blunt Wien : Seelenpein", "gehe", "Internetseite Verh\u00fcllungs-Verbot lustig", "Schwarz/T\u00fcrkis-Blau : Farbe , Namen", "Leben : Ex-Politiker Fall f\u00fcrs AMS", "Wien , Wien , ...", "Vermieter , Mieter zahlt ? \u00dcberblick", "Johann Lafer : Wolfsbarsch Bohnenp\u00fcree", "Interaktive Karte : Fl\u00fcchtlingsbewegung Europa", "\u00d6sterreich Fl\u00fcchtlinge : \u00fcberforderte Kontinent", "Staranwalt Manfred Ainedter feiert 66er", "Langzeitsch\u00e4den Populismus", "Geschichte Anschauen : Schlacht Gallipoli", "Kinder Vater Gef\u00e4ngnis sehen", "5 Dinge , Kroatien tunlichst vermeiden", "31 Lehren Nationalratswahl", "Regierung fixiert Sicherheitspaket : Milliarde zus\u00e4tzlich Heer", "Handel : KURIER-Magazin \" Karriere \u2013 Handel & Verkauf \"", "Nierenleiden :   Katzen trinken", "Causa Hausverwaltung IMV : Versicherer f\u00fchlen gesch\u00e4digt", "Verwirrung Dokument Van Bellen-Auftritt", "Leben Expats weltweit", "Jugend 2017 : Selbstdarstellung , Abstiegsangst Verunsicherung", "h\u00e4ufigsten Irrt\u00fcmer Erben Schenken", "\u00d6FB-EM-Kader : 23 Frauen \u00d6sterreich", "Ibuprofen , Diclofenac & Co : Spezielle Schmerzmittel erh\u00f6hen Herzinfarkt-Risiko", "Schmerzsalben Test : \" \"", "David Poisson Trainingssturz gestorben", "Plage Plagiatoren", "\u00d6sterreichs Klimaverpflichtung : 18 Ofen", "Deutsch-t\u00fcrkisches Gymnasium Istanbul : Weihnachts-Verbot", "spielen Kinder wichtig", "Kindern Kraft Leben", "T\u00fcrkei : Inflation erstmals zweistellig", "Joshua Jackson : Freundin verheiratetes Model Shafia West", "Singles : 30 schwierig , Partner finden", "Buwog-Prozess Karl-Heinz Grasser 12 . Dezember", "Nick Cave Wien : Engel , D\u00e4monen Magie", "Woche 47", "Andreas Salcher : \" Lehrer   unterrichten   2 . \"", "Christian Konrad : \" Diplomatie gebaut \"", "Motive : entfernen Frauen Haare Intimbereich", "pro Woche duschen", "Mietvertrag : 10 wichtigsten Tipps", "braun blau : Iris-Implantate Gesundheit schaden", "Wirtschaftskammer : Leitl sondiert Nachfolger", "Gl\u00fcckliche Gewinner Werbe-Amor", "Kurier vergibt Werbe-Amor", "A1 gl\u00e4nzte Werbe-Amor Gold", "Intelligenz-Test : \" 7 + 6= ? \" IQ 150 ?", "Dagmar Kollers Beziehung : \"   Sex \"", "Kornblume : geliebt Bismarck , Symbol \" Alldeutschen Vereinigung \" Blumenschmuck FP\u00d6", "3500 Euro falschen Pass", "Arzt-Kinder bitten \u00dcberpr\u00fcfung", "Cristiano Ronaldo : fad Date Frauenschwarm", "Tiersch\u00fctzer Druck Regierung", "Marcel Koller : Teamchef , Held S\u00fcndenbock", "S-Bahn-Ausbau : Aspern - H\u00fctteldorf 30 Minuten", "Gesichter Arztes Dr. L.", "Strache nennt m\u00f6gliche FP-Minister", "Gr\u00fcne beschlie\u00dfen \" Probezeit \" Fl\u00fcchtlinge", "Athina Onassis : leidet Dodas neuer Liebe", "Reportage Haus : Teenager Zeitung", "Herzogin Kate : Spitzen-Auftritt Gala-Dinner", "Gruft Republik : Bundespr\u00e4sidenten ruhen", "\u00d6VP-FP\u00d6 : freie Hand , Strache Vorbehalte", "Weihnachtskekse : Butterkekse", "Schlag Bau-Betrugsnetz : Schaden 55 Millionen Euro", "Krieau : historische Trabrennbahn Zentrum Stadtteils", "Freda Meissner-Blau : gr\u00fcne Galionsfigur fremd", "Tiefpunkt : Robbie Williams Sex Drogendealerin", "Fragen Antworten Vitamin D", "Neunk\u00f6pfiger Drogenring gesprengt", "Welt Didi Mateschitz", "Koalition : Montag interne Gespr\u00e4che Fachgruppen", "Internationaler Gl\u00fccks : zufrieden", "Zentralmatura Mathematik : Wissen L\u00f6sungen ?", "Cola K\u00f6rper passiert", "H\u00e4upl : Rot-Blau droht Spaltung SP\u00d6", "Frauenpower ORF-Sendung \" Zentrum \" Maria Fekter Meinung Frauenquoten ge\u00e4ndert", "\" v\u00f6llig unrealistisch , Schelling Job bekommt \"", "\" Cardillac \" : packender Psychothriller , Haut", "Dominic Thiem : Verliebt Vice Miss Tirol Romana Exenberger ?", "Hi Smile : Bleaching-Spielzeug Unsinn", "Redaktion Nieder\u00f6sterreich", "Viral : Barack Obama gratuliert Joe Biden Geburtstag", "Genossenschaftswohnungen", "Warteschlange M\u00fcnze \u00d6sterreich", "Rechnungshof kritisiert Planlosigkeit KAV", "Kefir herstellen", "\u00d6sterreicher Krankenkasse gro\u00dfteils zufrieden", "Arbeitsstunde kostet Schnitt 31,3 Euro", "Insiderin packt : \"   durchhalten \"", "24-Stunden-Betreuung : daheim Heim", "Pflegekr\u00e4fte : Wege Personalnot", "24-Stunden-Pflege : Qualit\u00e4t teurer", "Analyse : Woran 24-Stunden-Pflege krankt", "Pflegerinnen fordern Mindesthonorar", "Neues Restaurant : Wien : Gerstner er\u00f6ffnet Restaurant Oper", "Parlament : \u00d6VP \u00fcbergibt umstrittenes Dollfu\u00df-Bild Nieder\u00f6sterreichischen Landesmuseum", "Mobbing \u00d6sterreichs Schulen : schikaniert", "Neues Restaurant Bar3 : Br\u00fcder-Paar serviert Burger Retro-Cocktails", "Mugabes 37 vorbei", "U2-Verl\u00e4ngerung : Fahrt Seestadt", "Kendall Gisele : bestbezahlten Models 2017", "Stars h\u00f6chsten Intelligenzquotient", "Zitate \" Krieg Worte \" Nordkorea Trump", "Hollywoods Liebesszenen Wien", "Kamine \u00d6fen sorgen wohlige W\u00e4rme", "Burgenland : Suchtgift Cannabis-Zuchtanlage sichergestellt", "\u00d6sterreicher dicker : Experten fordern", "Rapid bindet Leistungstr\u00e4ger Auer 2020", "Cher : sieht Mama knapp 90", "fit : Schwangere Kate Tennis-Stunde", "EU-Richtlinie : Mentholzigaretten droht", "SP\u00d6 Wien : Startvorteil Michael Ludwig", "Bloggen Business ?", "Grado : Zeitreise", "Muslimische Jugend Studie : \" ang'f\u00e4ut \"", "Masterplan   Seebad : Geplante Umgestaltung nimmt Formen", "Ernest Hemingway Vorarlberg", "Religionen \u00d6sterreich : 700.000 Muslime , 5,16 Mio. Katholiken", "Restaurants : Wien : Onisando : Nudelsuppen japanische Sandwiches", "Ermittlungen : FP-Abgeordneter Frau verpr\u00fcgelt", "Weizer Autosalon Pichler pleite", "Salz & Pfeffer : Kim Chingu", "Salz & Pfeffer : A\u00ef Vienna", "unterst\u00fctzt   eigentlich Macron ?", "News : Invisibobbles sofort Gr\u00f6\u00dfen", "Bauernbund-Kandidaten bringen f\u00fcrs Pr\u00e4sidentenamt Position", "Oberlandesgericht Wien : Ermittlungen VW \u00d6sterreich endg\u00fcltig Tisch", "70-facher M\u00f6rder mithilfe \u00f6sterreichischen Ermittlern gefasst", "Besuch Falcos Villa Waldviertel", "Rugby-Regeln verst\u00e4ndlich", "Altersunterschied : Macrons Skandal ,", "Nummernschild Nazi-Code : Haft Bew\u00e4hrung", "Shiloh Pitt : Tochter Gesicht Papa", "Wiener SP\u00d6-Spitzenmann Protest : Alleingang K\u00fcr SP\u00d6-Vordenkerin", "5 stylishe Arten Jeans Herbst tragen", "Fl\u00fcchtlinge : 13 Pakistanis Herkunftsland r\u00fcckgef\u00fchrt", "Badewanne : Winter : Gesundheit : Vollbad Fitmacher", "The World 's 50 Best Restaurants : Steirereck geh\u00f6rt Top15 Welt", ": Smartphone-Nutzer brauchen 2,7 GB Daten Monat", "\" superintelligentes System Erde retten \"", "jungen Gr\u00fcnen alten m\u00e4chtig", "Henrik D\u00e4nemark Demenz \u00f6ffentlich", "Ablaufdatum 2030 Uhudler", "Jugendliche interviewten Staatsekret\u00e4r Integration", "Springers Finanzen.at erstmals \u00d6WA-sichtbar", "Sicherheit : Beschaulichkeit", "Frauenfu\u00dfball : Alltag M\u00e4rchen", "14 Festnahmen Drogenschwerpunkten Innsbruck", "Zwillinge \u00fcberleben Umarmung Uterus", "Weihnachtskekse : Vanillekipferl", "Vanillekipferl G\u00fcnther Erika Bisanz", "Ger\u00fchrt & gesch\u00fcttelt", "Bars : Miranda , Botanical Garden , Roberto , Kleinod , Franz Hahn", "Botanischer Cocktail-Garten Alsergrund", "60er : Erwin Steinhauer Portr\u00e4t", "Brad PItt : Pl\u00f6tzlich fast faltenfrei", "Angelina Jolie : Pitt Therapie Klinik gezwungen", "Brad Pitt Angelina Jolie getrennt ? Enth\u00fcllungs Doku Brangelina", "Angelina Jolies neuer Villa Malibu", "Fu\u00dfball-Bundesliga : Sturm glanzlosem Sieg Ried", "Top 10 : Vintage-Modeshops", "Beauty-Adventkalender 2017", "K\u00f6rpergr\u00f6\u00dfe Gesundheit beeinflusst", "shadeloops : Grazerin Brillenketten hip", "Affront Genderforscher", "Rapid-Trainer Abteilungsleiter Bundesheer", "Top 5 : Fr\u00fchst\u00fccken Wien 1010", "Portr\u00e4t Schauspielerin Martina Ebm", "Herzogin Kate gesteht : \" Einsam \" Mutter", "Top 5 : Pizzerien Wien", "Talkrunde Wirtschaft ungest\u00f6rt bleiben", "Gro\u00dfbritannien : Theresa Mays kapitale Fehler Wahlkampf", "Feigen : ges\u00fcnder - getrocknete frische ?", "Heinz-Christian Strache Vielfrontenkampf", "Paaradox : Last Liste", "Weckruf Umweltschutz", "Reform Sozialversicherung : einheitliche Kassenleistungen", "Kombinierer Seidl Podestkurs", "Douglasie Fichte : \u00e4ndert Klima W\u00e4lder", "Krone-Berater attackiert Puls4", "Schnitt Schmitt", "NR-Wahl : Fu\u00dfi bietet 30.000 Euro Informationen Email-Leak", "Baustopp Mauer Ballhausplatz", "Kahlschlag Studienpl\u00e4tzen : Regierung gr\u00fcnes Licht Studienplatzbegrenzungen", "Bad Gastein : Monte Carlo Alpenwelt", "Heintje 60 . Geburtstag : sieht Hein Simons", "\u00d6sterreichs Sch\u00fcler Trinken Europameister", "Jennifer Aniston : Zusammenbruch Brad Pitt", "Rauchfreie Lokale : Offener Experten-Brief", "\u00d6sterreich w\u00e4chst : 8,77 Millionen Einwohner Jahresbeginn", "Deutsch Voraussetzung   Wohnbeihilfe", "Prominent & spornosexuell", "Tiroler Gletscherehe liegt Eis", "Barbara van Melle gr\u00fcndet Brotback-Atelier Wien", "Formel 1 : Ferrari 2018 Kimi R\u00e4ikk\u00f6nen", "Erdo\u011fan plante Islam-Schule 2013 : illegal", "Andreas Onea : Versp\u00e4tung Mexiko", "K\u00f6stinger \u00d6VP 1 . Nationalratspr\u00e4sidentin aufgestellt", "Eklat geplante Neudefinierung Familie Kroatien", "Entf\u00fchrung Lugners Frau gedroht : Bedingte Einweisung", "Italien : Fabrikarbeiter gewann Tiramisu-Weltmeisterschaft", "Schelling Paradise Papers : Politiker \u00d6sterreich involviert", "Sneakers New Balance", "Allzeithoch Nestle-Aktie aggressiven Investor", "Sexualtherapeutin : Paare Seitensprung lernen", "Monte Carlo TV-Festival : F\u00fcrstin Charlene l\u00e4sst tief blicken", "OECD : \u00f6sterreichische Schulsystem teuer", "Tiroler M\u00fcnchen : Marco Friedl ?", "Adventkalender", "Binden-Werbung zeigt Blut", "Vienna Regionalliga absteigen", "Vorw\u00fcrfe Peter Pilz", "Sieger : Vanillekipferl Hansj\u00f6rg Schopper", "Abrechnung Pr\u00f6ll Dichand", "Uners\u00e4ttliche Lufthansa : Tickets teurer", "Influenza : wissen", ": \" FP\u00d6 Juniorpartner Koalition \"", "Wohnzimmern Republik", "Wiener Neudorf : Transporter steckte Unterf\u00fchrung fest", "Organversagen : S\u00e4nger David Cassidy gestorben", "Prinzessin Anne F\u00eate Imp\u00e9riale Wien", "\u00d6VP : Streit ums Geld bremst Kassen-Fusion", "Gert Korentschnig", "Ehrung : Ambros-Clan harmonisch vereint", "Czernohorszky Ethikunterricht", "Koalitionsverhandlungen : fordert Haltung Antisemitismus", "Wien : Gesch\u00e4ft Parken", "T\u00fcrkische Gastarbeiter : dringend gesucht , ignoriert", "Fiesta Mexicana A1", "Periorale Dermatitis : Haut Pflege \u00fcberfordert", "Milliarden-Pleite Alpine : Republik get\u00e4uscht ?", "Alpine-Krimi : Persilschein Spanier Energie-Deal", "Armenien & Georgien : Angesicht heiligen Berges", "Dianas Reitlehrer : \" Harrys Vater \"", "Stars Woche :   WOLF ALICE", "Herr-lich : M\u00e4nner St\u00f6ckelschuhen", "Kultur Kulinarik italienischen Region Emilia Romagna", "Haute Couture Eiffelturm", "\u00dcberfall Juwelier : Alarmfahndung Innsbruck", "H\u00fcfte Knie : Abn\u00fctzungen Verfahren erfolgreich behandelt", "Trainer verr\u00e4t : hart trainiert Shakira Tour", "Starkoch Reinhard Gerer pleite", "Kind HIV-Behandlung Virus", "Welt-Aids-Tag , Hauptproblem sp\u00e4te Diagnose : 30.000 HIV-Neuinfektionen Europa", "Britischer HIV-Patient offenbar geheilt", "Dapivirine : Vaginalring HIV", "Therapie HIV ansteckend", "Neues Restaurant : Portugiesisches Restaurant Naschmarkt", "Tabria Majors Sports Illustrated : Plus-Size-Models Kurzzeit-Trend", "Model Ashley Graham : Foto Cellulite-Kritiker", "Instagram : Model Ashley Graham zeigt Cellulite", "COP23 : Fortschritte L\u00e4hmung US-Ausstieg", "Todkranker Hund begleitet Besitzerin Traualtar", "Vorspeise : Filet Forelle Spitzkohl Rieslingsauce", "Klasse voller Fl\u00fcchtlingskinder", "Brigitte Trogneux : Geheimnis jugendlichen Aussehens", "Beamtengeh\u00e4lter : O\u00d6 zieht , Demo geplant", "falscher Toleranz", "Fr\u00fchst\u00fcck Barbara Pachl-Eberhart", "Sohn Lilian Klebow", "Ratenzahlung Pensionisten", "Weichenstellung : Burgenland-SP\u00d6 k\u00fcrt Doskozil Finanzlandesrat", "unheimliche Lust Weltuntergang", "Leberk\u00e4se-Test", "\" Spielen Glaubw\u00fcrdigkeit \"", "\" Big Bang Theory\"-Star Melissa Rauch Fehlgeburt schwanger", "# IHadAMiscarriage : Schweigen Fehlgeburten brechen", "Fehlgeburt : Frauen erz\u00e4hlen Geschichte", "Freiheitlichen Rauchverbot Mai 2018 kippen", "Stadtgespr\u00e4ch : Land jugendlichen Raucher", "S\u00e4mtliche Erz\u00e4hlungen - Ingeborg Bachmann", "schnelle Geld lockt illegalen Stra\u00dfenstrich", "Restaurants : Wien : 13 Restaurants", "Kensington Palast : Schatten Buckingham Palace", "Lebensversicherungen : VKI-Sammelaktion endet", "EU-Beh\u00f6rden : \" Watsche Wien \"", "Vergewaltigung : 4,5 plus Einweisung 14-J\u00e4hrigen Graz", "Stadtwache-Chef best\u00e4tigt \u201e Hitler-Zitat \u201c", "Achtung : Pilze giftige Doppelg\u00e4nger", "Peter Pilz holt prominente Kandidaten Wissenschaft", "Vassilakou Baur Volf", "Gro\u00dfbaustelle Sozialsystem", "Geschichte hautnah Museum Nieder\u00f6sterreich", "Ledige V\u00e4ter erhalten Obsorge", "K\u00e4rnten : Perchten Umzug Rand Band", "Trends Zukunft laut Lidewij Edelkoort : Influencer Instagram-Stars unwichtig", "Versicherungs-Vergleich Reisende", "postgefaktet ?", "Van Bellen empfing Strache freundschaftlich", "Peter Pilz : \" gr\u00fcne Partei wurscht \"", "Liste Pilz startklar : 20 Kandidaten fix", "Wirtschaftsfaktor Walzer", "16-j\u00e4hrige Ungarin Wien Bordell befreit", "\" Mindestsicherung \" Gr\u00fcn-Klub h\u00e4ngt neuer Nationalratspr\u00e4sidentin K\u00f6stinger", "\" Oma Putz \" Trude Fukar gestorben", "Haus Marmor Grabsteinen", "Airbus : Brauchen rasch Startschuss deutsch-franz\u00f6sischen Kampfjet", "Diethart : \" warst , irgendwo \"", "Bosnien-Herzegowina : Wahhabiten-St\u00fctzpunkt Europa", "Sigmund Freud Privatuni : Herbst Medizin-Studium 11.000 Euro", "Steiermark : Verseuchtes Pferdefleisch verkauft", "dick , : Basinger-Tochter wehrt", "10 Nahrungsmittel Eisenmangel", "ATP Finals : Thiem verpasst Einzug Semifinale", "Klimawandel bedroht Tiefsee-Lebewesen", "Wien : Lehrer t\u00fcrkischen Sch\u00fcler gew\u00fcrgt - Polizei ermittelt", "gekocht : Miele erfindet Dialoggarer", "Markus Miele spricht Weltneuheit Dialoggaren", "\u00d6tztal Tirol : Wandertheater Berg", "Feuer Eis : Island Reiseziel bietet", "Sharjah-Emirat :   feudale Glitzern 1001 Nacht", "Griechenland abseits Massen : Urlaub Freunden Pilion", "Ski alpin : \u00d6SV-Pr\u00e4sident Peter Schr\u00f6cksnadel hinterfragt Erfolgs-System", "Haus abgebrannt Versicherung Stich gelassen", "Stimmungsvolle Adventfahrten \u00d6BB ErlebnisBahn", "Piktogramme : Film Sekunden", "Neuer Lieferservice Foodora Wien", "Explosiver Fund Seegrund", "Pflichten Gartenbesitzern", "Land Titel : w\u00e4hlt Anrede ?", "\" Existenzangst Schlimmste , \"", "Post erweitert App Prospekt-Werbewirkung", "Witzigmanns Welt : K\u00fcrbis", "Insekten essen : Proteinquelle Zukunft ?", "Charlotte Casiraghi : Sohn Raphael", "Provence Frankreich : Versteckte   Sch\u00f6nheiten abseits Nizza Cannes", "Unterliegt Wohnung MRG ?", "KH Nord : \u00d6VP Sachen U-Kommission Druck FP\u00d6", "OECD-Studie attestiert Lehrermangel : Quereinsteiger gesucht", "AK-Test : Nuss-Nougat-Cremes : Problemstoffe Produkt", "Lila Grace sch\u00e4mt Mama Kate Moss", "\u00d6l : Kult-Sardinen Nuri kehren", "Skifahren Familien \u00d6sterreich leistbar", "Sex sells \u2013 gilt Schulb\u00fccher", "M\u00e4nner Pranger : \" Erektion Weg \"", "Land Betriebe nehmen 69 Lehrlinge  ", "TUIfly nimmt Flugzeuge Niki", "NR-Wahl 2017 : \u00d6sterreich w\u00e4hlt - Nationalratswahl Live-Ticker", "Haft Einbruch Ex-Skirennl\u00e4uferin Maria H\u00f6fl-Riesch", "braucht Sozialpartner ?", "\u00d6SV-Star Max Franz Interview : \" Bl\u00f6dsinn bauen \"", "Erdogan junge Musliminnen : \" Heiratet vermehrt \"", "Pia Hierzegger Josef Haders \" Wilde Maus \" : \" st\u00e4ndig irgendwie l\u00e4cherlich \"", "Last-Minute-Sieg Salzburg Mattersburg", "Bodyblog : Sensofit Stabililt\u00e4t", "Liebesouting : Hader bekennt Pia", "Mondkalender : Haare schneiden f\u00e4rben", "Trump preist \" unsichtbaren \" Kampfjet US-K\u00fcstenwache", "\u00d6sterreich Alkoholproblem", "Vertikal Wohnen : Wien w\u00e4chst", "\" tot \" : BZ\u00d6 tritt Wahl", "Strache Mindestsicherung k\u00fcrzen : \" Dach \u00fcberm Kopf 40 \u20ac Monat \"", "Asyl-Gutachter : \" R\u00fcckst\u00e4ndiges Islamverst\u00e4ndnis \"", "H\u00e4upl-Ehefrau WGKK-Chefin", "Ayda Field spricht Liebesleben Robbie Williams", "\" \u00d6fter getrennt \" : Robbie Wiliams Beziehungskrise Ayda Field", "Neues Restaurant : Leberkas-Pepi er\u00f6ffnet : Wiener st\u00fcrmen Leberkas-Pepi", "Extremismus : r\u00fccken Mitte", "Frauen suchen Wahrheit , Schuld S\u00fchne", "Sozialversicherung : Tr\u00e4ger effizienter 21", "Gault&Millau 2017 : Restaurants Bundesl\u00e4ndern", "Anna Netrebko : Offene Worte autistischen Sohn", "Ozzy Osbourne spricht Aff\u00e4re : \" Idiot \"", "Kelly Osbourne twittert Telefonnummer Ozzys Aff\u00e4re", "Tschetschenen \u00d6sterreich : missgl\u00fcckte Integration", "Florian Holzer : Top 5 : Lokale offenem Kamin", "Forscher starten Unterschriften-Aktion Umweltschutz", "Gesch\u00e4fte Gottes Segen", "Neues Restaurant : Edel-Japaner A\u00ef er\u00f6ffnet Goldenen Quartier", "Ex-BMW-Manager Clary wechselt Mercedes Wiesenthal", "Life Ball 2013 : Ausgesperrte Life-Ball-G\u00e4ste : Stadt Keszler L\u00f6sung finden", "Nationalratswahl 2017 : Steckbrief Christian Kern", "Feuer zerst\u00f6rte S\u00e4gewerk Lofer", "\" Himmel \" Josefstadt : Grandioses Gef\u00fchlskino Theaterb\u00fchne", "Eduard Habsburg Schloss-Geheimnisse", "reagiert Netz Glawischnig-R\u00fccktritt", "Tanzen jungen schick", "Schnellkurs sp\u00e4tberufene Lehrer Joberfahrung", "\" Kunden n\u00fctzen Kurs Einstieg \"", "J\u00e4gerball : Promi-Pirsch Parkett", "Deutsche Bank warnt Investitionen Bitcoin", "Russe 4 Mrd. Dollar Bitcoin gewaschen", "Social Media Manager m/w", "Tagwache Kratky Milit\u00e4rhundezentrum", "Sch\u00f6nborn Jeann\u00e9e : Kardinal kritisiert Aggression \" Krone \"", "Sexorgien & Kontrollverlust : Enth\u00fcllungsbuch Kate Moss", "Marc Janko : \" stehe Kritik \"", "WEF-Studie : Land meisten Stunden gearbeitet", "Kr\u00e4ftige Ohrfeige Trump Jahrestag : Wahlergebnis wider Hass Spaltung", "U-21-Team : jung stark Serbien", "Katzen Winterfell bekommen", "Bangladesch weist Myanmar geflohene Rohingya", "Pikant : Weinbau-Betrieb Mal pleite", "Hunde Schlafzimmer f\u00f6rdern Schlaf", "Ministergeh\u00e4lter Spanischer Hofreitschule", "Strache schont waidwunden Kern", "Charlotte Casiraghi Lamberto Sanfelice : Kussbilder best\u00e4tigen Liebe", "Praktika Einstieg Job eher Ausbeutung ?", "Redaktion Tirol", "Ivanka Trump liebt Jogginghosen-Look", "\" Park-Sheriffs \" Wiener Polizei", "Tagebuch Wolfgang Winheim : Erfolg ausblieb , 's Spa\u00df vorbei", "Tagebuch , Wolfgang Winheim : Unterschied gr\u00f6\u00dften Verb\u00e4nden", "Tagebuch , Wolfgang Winheim : Gedenken Poisson : Saisonstart Trauerflor", "Wien-R\u00e4tsel : liegt Stadt ?", "Polizei warnt Betrug Bitcoin-Ladebons", "Positionencheck NR-Wahl : sagen Parteien freien Uni-Zugang ?", "Busek wei\u00df : 70 50", "Schwarz-blaue Koalition : Clustersprecher Verhandlungen festgelegt", "Therese Schwarzenberg : \u201e finde Mann anziehend , absolut \u201c", "Wahl 2017 : Landes- Gemeindeergebnisse", "Stiege 8 / T\u00fcr 7 : Sissy Springinklee , Hausmeisterin Gemeindebau", "# Stadt : Rettet \u201e H\u00e4ngl \u201c !", "Scheidung   Kate & Williams Freunden", "\u00d6VP schwer", "Gerstner Schlumberger er\u00f6ffnen Caf\u00e9", "Pflegeskandal : Heim wusste Sommer Bescheid", "Basketball-EM-Qualifikation : \u00d6BV-Herren z\u00e4hlt D\u00e4nemark Sieg", "Vitiligo : Model trotz seltener Hautkrankheit", "Make-up Haare : 10 Beauty-Ideen Festtage", "Protzhochzeit : Bieber-Ex Xenia Deli Million\u00e4r geheiratet", "Fu\u00dfball : Liverpool er\u00f6ffnet Leicester erweitertes Stadion Anfield Road", "Doppelmord Stiwoll : \" f\u00fchlt Opfer , T\u00e4ter \"", "Zuckerfallen : W\u00fcrfelzucker versteckt Ketchup Co.", "Top 10 Essen Sonntag", "Katrin Kr\u00fcger : Liebe Spanier", "Gletscher Klimawandel aussagen", "Geh , wohin Herz tr\u00e4gt - Susanna Tamaro", "Djuricin : \" gespuckt \"", "T\u00e4gliche Turnstunde September Schulen Bundesl\u00e4ndern", "Haarprobe Ehefrau Waffe Rosenkrieg", "Hitlergru\u00df-Foto : FP\u00d6-Mann Andreas Bors tritt Bundesrats-Mandat", "Kind Haustier Freunde", "Muttertag Estibaliz Carranza", "Rodeln : Nico Gleirscher Sprintrang 3 erstmals Weltcup-Podest", "Parteifinanzen : \" Newcomer Nachteil \"", "Faymann-H\u00e4upl Foto Wahlabend ? manipuliert \" Krone \"", "Trotz Skoliose : Ballerina stoppen", "Blick Atelier-Kulissen", "Gertraude Portisch : \" Enkelkinder Trost \"", "Wiener Luxus-Wohnungen gefragt", "\" \u00d6sterreich bombardieren \"", "G\u00e4nse-Lokale", "offenen Moschee Deutschland", "Seyran Ate\u015f : H\u00e4nde mutigen Frau", "Internationaler Vergleich : \u00d6sterreichs Muslime hinken", "H\u00f6chstgericht gr\u00fcnes Licht Waffenpass Jagd", "Innenministerium plant Zaun Grenze Ungarn", "Babyfaces Zeiten Aufschwungs gefragt", "kurze Hormonersatztherapie f\u00fchrt Eierstockkrebs", "Drogen Stra\u00dfenverkehr : Vortestger\u00e4te gefordert", "Angelina Jolie : Zell-Therapie hilft Zunehmen", "Einst Haider , : Karriere Josef Moser", "Josef Moser neu Team : \" passieren , liegt Tisch \"", "M\u00e4nner-Hormon formt Revoluzzer", "Chorherr : Spendenliste Beigeschmack", "Linzer Beamte demonstrieren Krampustag", "KURIER \u00fcbersiedelt neues Haus", "Schirnhofer schlie\u00dft Filialen setzt \u00d6ko-Fleisch", "Heidi Klum : \" Weinstein Einzelfall \"", "Bob Weinstein : \" Bruder kranker Mann \"", "Harvey Weinstein : Angelina Jolie & Gwyneth Paltrow prangern Weinstein", "Gr\u00fcnde , Arbeitslosigkeit steigt", "Semmering : Millionen-Krimi Weltcupjahr", "Hannes Arch : 100 km/h Tod", "Afghanen \u00d6sterreich : \" Mal Opfer \"", "1920 Euro Strafe Hassposting", "Genehmigungsverfahren : \" Volksverm\u00f6gen verschleudert \"", "Fl\u00fcchtling , Asylwerber , Migrant - ?", "Guide Michelin : 19 Sterne \u00d6sterreich", "Pro-EU : L\u00e4nder beitreten", "US-Schauspielerin wirft Weinstein Vergewaltigung", "ZDF-Moderatorin Babette Kienlin bricht Sendung", "Friedhof-Fantasien", "Tiercoach Chinaseuche \" Rabbit Haemorrhagic Disease \" : Impfung Kaninchen sch\u00fctzen", "\" Friends\"-Stars TV-Special wiedervereint", "Toter Rekrut : \" gelacht \"", "Tarek Leitner schweigen", "Krampfadern : operieren n\u00f6tig ?", "Shakespeare reloaded", "Max Schmiedl", "Abschiebungen verhindert", "R\u00fcckspiegel : Emotionen Visier", "Digitale Kompetenz Jugendlicher : Learning by doing", "Alice Cooper : bisschen Horrorshow", "Top 5 : Pizzerias Wien", "Athina Onassis : Doda horrende Abfindung bezahlen ?", "Athina Onassis & Doda : Details Trennung enth\u00fcllt", "Athina Onassis : Schweres Leben trotz Milliarden", "Neues Restaurant : Ex-Skirennl\u00e4ufer Thomas Sykora Gastwirt", "Madame Zeitlos Bildarchiv", "EU-Justizminister beschlie\u00dfen Europ\u00e4ische Staatsanwaltschaft", "Via Youtube & Co. : bringt sexuelle Aufkl\u00e4rung Netz ?", "Frankreichs Emmanuel Brigitte Macron : \" Plastilin ihren H\u00e4nden \"", "Boiler Room Wien : HVOB & Freunde", "Unterschriften sammeln W\u00f6lfe \u00d6sterreich", "Freizeitrose Marcello de Nardo", "\" Volksfeind \" Burgtheater : \u00d6ko-Troll Eislaufverein", "Plakat abmontiert ,     angeblicher Wolfsgefahr warnt", "Michael Ludwig : Bekenntnis Rot-Gr\u00fcn", "Get your teacher : Schulen Lehrer aussuchen", "Festnahme Pr\u00fcgelvideo", "Staubsaugeraufsatz R\u00e4uber Flucht geschlagen : \" Rechnet 7 \"", "Naddel abd el Farrag Alkoholsucht : \" Pegeltrinkerin \"", "Michael Ludwig : langem Atem Weg H\u00e4upl-Nachfolge", "Kochwasser Kukuruz gesalzen", "Jungmediziner \u00d6sterreich verlassen", "Mixer-Test : richtigen Dreh", "Chalets : Winter-Hideaways \u00d6sterreich", "Constantia Flexibles stellt Organisationsstruktur", "Chinesen kaufen bekannten Wiener Verm\u00f6gensverwalter", "Adelsmayr : EU-Kommission Dubai vermitteln", "Adelsmayr : \" \"", "Dubai-Arzt Eugen Adelsmayr : \u201e offiziell unschuldig \u201c", "Frau falschen Pass", "Volkshilfe spart   Personal", "Neuer Wirbel Mineral\u00f6lkonzern OMV : \u00d6l , Gas Lederhosen", "Mitschneider", "\u00d6sterreich 577.000 Tonnen Lebensmittel sparen", "Adam Levine urteilt Make-up Alicia Keys", "MTV Movie Awards : Stars zeigten Bein", "Morddrohungen Wahlaufruf : \" Pl\u00e4diere Menschlichkeit \u2013 bekomme , Hass \"", "GolfOpen : KURIER gewinnt ProAm-Turnier", "Kurier TV-News : Kritik Doskozil", "Preisabsprachen : Lkw-Hersteller Rekord-Geldstrafe zahlen", "Theater Jugend : Zusammenhalt \u201e Fluch \u201c Mobbing", "Tennis : Dimitrow London-Titel Nummer , Thiem", "20 KURIER freizeit", "Treffpunkt Wien : Strada del Siam", "Hirschers doppelter Befreiungsschlag", "Verh\u00fcllungsverbot : Kritik Wien , Anzeigen", "Burkaverbot Kraft : Polizei verzichtete Strafen", "52 fast vergessenen Toten", "K\u00f6stinger Pr\u00e4sidentin \" Geringsch\u00e4tzung Parlaments \"", "\" alt \" : Million\u00e4rs-Ex Bj\u00f6rn Lefnaer beleidigt Patricia Blanco", "wichtigsten Punkte Gr\u00fcnen-Wahlprogramm", "wichtigsten Punkte NEOS-Wahlprogramm", "\u00d6SV-Damen-Cheftrainer J\u00fcrgen Kriechbaum : \" \"", "Tipps Reise\u00fcbelkeit", "Silvester : Sekt-Lexikon : Sprudel wissen", "Falle Feminismus", "\u201e M\u00e4nnerorientierte Medien geben Herrn Eia B\u00fchne \u201c", "AMS strich vierk\u00f6pfiger Familie Notstandshilfe", "Phantom mis\u00e9rable : Klage Agentur", "Nationalrat : Liste Pilz Parlamentspartei", "Krise europ\u00e4ischen Sozialdemokratie : Parteien Aufwind", "Yung Hurn : Wiener Rapper Palina Rojinski ?", "Novelle Verbotsliste braune Kennzeichen", "Playlists Weihnachtsfeier", "Manfred Deix gestorben : Beach Boy Zeichnern", "Wahl 2017 : Mandatsverteilung", "Vokuhila !", "Pirlo schwer beeindrucken", "Ernst Molden : Erdbergerin", "Lohnverhandlungen : 2,33 Prozent Beamte", "Achtung Burka", "Burka Europa verboten", "Abnehmen Hypnose : funktioniert 's", "Umweltschutz kurbelt Wirtschaft", "Georgina Fleurs Mutter : \" vermute , Georgina Callgirl \"", "Studie : Schulter-OPs \u00fcberfl\u00fcssig", "Joshua Jackson Beziehung Diane Kruger : \" Treu bleiben schwer \"", "Karl-Heinz Grasser : Moser   Fall Porr anklagereif", "Realos Fundis : Roter Richtungsstreit", "Todessch\u00fctze Las Vegas : \" Normalo \" Nebenan", "\" America first \" gilt Trumps Luxusanwesen : Haupts\u00e4chlich Nicht-Amerikaner Mar-a-Lago besch\u00e4ftigt", "Aufgaben Deutsch-Zentralmatura", "Frau h\u00f6chster Polizist Landes", "Wochenbettdepression : Postnatale Depression : Baby-Blues : Frauen Wochenbett leiden", "Al Bano & Romina Power : Tochter heiratet Million\u00e4r", "Print-Auflagen Halbjahres 2014", "7 Freizeit : Veranstaltungstipps Woche", "Justizminister Brandstetter besprach \" Reichsb\u00fcrger \" Malta", "Steuerparadiese OMV", "Medizin-Mythen : \" Intelligenz trainieren ? \"", "Gipfeltreffen IQ-Elite", "Interview Sexleben Muslime : Arabische Bettgeschichten", "\u00d6sterreich r\u00fcckt rechts : reagiert Netz", "GesundheitsApps Kinder : Handy ges\u00fcnder", "Gault&Millau 2017 : Hauben-Restaurants \u00d6sterreich", "Gault & Millau : Hauben-Restaurants", "Gault & Millau : Aufsteiger & Absteiger", "Latein Wien : Inschriften Europahymne", "Seen privater Hand : \" Neid gr\u00f6\u00dfer , wert \"", "Silberstein : Entlastungsoffensive SP\u00d6 ger\u00e4t erneut Wanken", "Transkript : SP\u00d6-Chef Christian Kern Causa Tal Silberstein", "Steckt Silberstein \" \" Facebook-Seite ?", "SP\u00d6 startet Flucht vorn ortet \u00d6VP-\"Maulw\u00fcrfe \"", "Obamas Christmas Card regt", "Gr\u00f6\u00dfte Bank Chinas er\u00f6ffnet Standort Wien", "Antisemitismus : R\u00fclpser FP\u00d6", "Kern verurteilt Aussagen FP\u00d6-Nationalrat H\u00fcbner", "Yung Hurn : \" Cocobello \" Gemeindebau", "Restaurants", "Eduard Josef Wimmer-Wisgrill : Vollendetes", "Sex-Vorw\u00fcrfe Bill Clinton", "Brisant : Madame Nina erz\u00e4hlt Promi-Kunden Charlie Sheen Falco", "Restaurants : Wirtsh\u00e4user Wien", "Peter Kraus : Panikattacken TV-Unfall", "Gesucht , gefunden : pers\u00f6nlichen Doppelg\u00e4nger findet", "abonnieren : Brandst\u00e4tters Weckruf", "Illusion Gleichheit", "antiautorit\u00e4re Gesellschaft \u2013 Albtraum", "Schiefes Minarett Mossul gesprengt : \" gesteht IS Niederlage \"", "\u00d6VP FP\u00d6 beschleunigen Tempo Koalitionsverhandlungen", "Metallischer Geschmack Mund : bedeuten ?", "\" Trag\u00f6die w\u00fcrdig \"", "Gabriel Schulz trafen Ex-Kollegen Faymann", "Faymann-Firma hoffnungsvoll unterwegs", "Laien Pfarrleitungen", "J\u00e4ger verlorenen Klostersch\u00e4tze", "Verbl\u00fcffend : Symmetrische Promi-Gesichter", "Mirella Ponce : Polizeifoto viralen Hit", "Paris : Zirkus entlaufener Tiger erschossen", "Trennung Skirennl\u00e4uferin Michaela Dorfmeister", "Streit Verkauf Sozialwohnungen", "Neues Image : Wandel Johanna Mikl-Leitner", "Ulrich Reinthaller : \u201e Potenzial , M\u00f6rder   \u201c", ", 30 Stunden arbeiteten ?", "Ern\u00e4hrung : Vollwertkost beugt Depressionen", "BAWAG-Mitteilungen E-Banking-Postfach unwirksam", "KURIER-Magazin Start-up !", "Feine Feigen : herkommt", "GEN Summit : \" Washington Post\"-Chefredakteur Baron Medien : Social Media \u00e4ndert journalistischen Tonfall", "Bloggerin zeigt , Krafttraining K\u00f6rper transformiert", "Staatssekret\u00e4re Budget Koordinierung Kanzler Sebastian ?", "Abschiebungen freiwillige Ausreisen", "Charlene Albert : Zwillinge", "Mundhygiene : 10 Tipps sch\u00f6ne Z\u00e4hne", "Z\u00e4hne : Heilung : Gesundheit beginnt Mund", "Kurz-Leaks : \u00d6VP gerne gewusst", "Film Nina Proll Hofburg", "Helfen Selbstverst\u00e4ndlichkeit : 23-J\u00e4hrige nimmt 30 Syrer", "Hochzeit : Wolfgang Ambros verlobt", "Malta : Schock t\u00f6dlicher Attacke Investigativjournalistin", "Verdacht : 60 Imame Ausland finanziert", "Moment , Donald Trump Ehefrau verga\u00df", "Leo Hillinger sucht Puls 4 Winzer", "Instagram-Account \" Nippel\"-Torte gesperrt", "Thomas Conrad Brezina", "Erfolg Thomas Brezina Frankreich", "Forscher transplantieren Korallen Great Barrier Reef", "Strache besteht 50 Prozent FP\u00d6-Inhalte", "\" Hypo IV\"-Prozess : Schuldspr\u00fcche Kulterer & Co", "Infografik : weibliche Orgasmus", "\" eure erhalten \"", "Josef Cap neuem Posten entlohnt", "Gregor Schlierenzauer : Trennung Freundin", "Nestroy-Preise : Improvisation Drehbuch", "Red Bull : Magazin berichtet drohenden Machtverlust Mateschitz", "10 Tricks , Weihnachtsessen gelingt", "Aromatherapie Hunde : Heilung \u00d6le", "\" normal \" : finden psychischen Erkrankungen Verst\u00e4ndnis Arbeit", "AUA fliegt China", "Eklat Staatsoper : \" Tosca \" Tosca weiterlaufen", "Zentralmatura Mathe f\u00fcrchten", "Migranten st\u00e4rkste Kraft Schule", "Durchfallen : Praktiker \" Meisterst\u00fcck \"", "Mittelschule : \" verlorene Generation \"", "Ski alpin : \u00d6SV-Pr\u00e4sident Peter Schr\u00f6cksnadel Rechnungshofbericht WM 2013 erbost", "\u00d6SV-Pr\u00e4sident Peter Schr\u00f6cksnadel Interview : \" Erfolg \"", "Rechnungshof : F\u00f6rder-Chaos Ski-WM 2013 Schladming", "Keira Knightley : Jahrelang Per\u00fccke getragen", "Ambros : Mann zw\u00f6lf Leben", "Tafelspitz 2015 : App & Magazin neu zubereitet", "Studentin erstickte : Brandstiftung Mordfall", "Studentin erstickt Brand", "Mordprozess : Brandstiftung Hohen Markt", "Explosion Hohen Markt : Prozess Mord 14-fachen Mordversuch", "Herzogin Kate : Enth\u00fcllung Gro\u00dfmutter", "Zieger verl\u00e4sst WirtschaftsBlatt", "Zieger Wirtschaftsblatt", "Vanillekipferl Thomas Wiltschi", "Verlagsgruppe News stellt Zukunftsweichen", "Joe Biden : nostalgische Rettungsschwimmer", "Helikopter made Austria : Hochgeschraubte Pl\u00e4ne Bundesheer", "Model \u00fcbt heftige Kritik Magerwahn Modebranche", "Amtsmissbrauch : Freispruch Arzt Opfer Richter anzeigen", "US-Waffengesetzen \u00e4ndern", "Kern \" bester traurigster Kanzler \"", "& Kate : Geburtstermin offiziell gegeben", "Coup Bank Looshaus : T\u00e4ter Videos", "\" The Walking Dead \" : Staffel 23 . Oktober", "Venedigs B\u00fcrgermeister klagt hohe Wiener Kaffee-Preise", "Pammesberger : \" Wasser \"", "Jung Transgender : Roman Roxy", "\" H\u00f6r mal h\u00e4mmert\"-Stars ?", "Jamaika-Verhandlungen : Hurrikan-Warnung Offener Brief", "Best of Pammesberger", "Blick vorn ! 2016 Sicht Karikaturisten", "Trump-Karikaturen", "20 Pammesberger", "Theater : Donald Trump gro\u00dfartig ...", "Psychiater Hans-Otto Thomashoff erkl\u00e4rt : Zufriedenheit bringt Gl\u00fcck", "Teenager Zeitung - Jugendliche \u00fcbernehmen KURIER Redaktion", "Fotos Sprach-Schnupper-Einheiten", "\u00d6BB Pl\u00e4ne \" Horner Schleife \" Tisch", "Quiz \u00f6sterreichische K\u00fcchensprache : Schmeckt Cola lecker ?", "Pammesberger : Manfred Deix fehlt", "Diskussion : Leitungswasser kosten", "Gault & Millau : Restaurants Landes", "Personalmangel : \u00c4rzte-Protest Pflegewohnhaus", "Gottwald Kranebitter : Berater , Bergsteiger Bio-Imker", "Neues Restaurant : Martin Ho er\u00f6ffnet Ivy 's Pho House", "Eveline Eselb\u00f6ck : \u201e kochen \u201c", "Scharner : Austria feierte 2003 Rotlichtmilieu", "Gewaltverbrechen : Tote Perchtoldsdorf", "Tom Cruise : Geheimfreundin packt Wutanf\u00e4lle", "Verhaltensexperte : Melania Ivanka denkt", "Verhaltensexperte analysiert : Melania Donald Trumps K\u00f6rpersprache Inauguration", "Promis BH - Trend", "Amtsmissbrauch : Wiener Polizist freigesprochen", "Vanillekipferl Uroma", "Movimiento Ayuda C\u00e1ncer de Mama : Singende Br\u00fcste Facebook-Zensur", "Facebook l\u00f6scht Bilder nackter Neptunstatue", "Spitze", "Cernko schnappte Frau Chefsessel weg", "Social-Media-Stars   Realit\u00e4t Internet-Blase", "Ausraster Facebook : Til Schweiger platzt Kragen", "Social Media-Kommunikation Freunden verst\u00e4rkt \u00c4ngste", "Vermisstes U-Boot : Suche S\u00fcdatlantik intensiviert", "Argentinien : Suche vermisstem U-Boot", "Lilian Klebow : \" Soko Donau\"-Star schwanger", "geheimnisvolle Welt Dietrich Mateschitz", "15 spannende Fakten Wissbegierige", "Saudi-Arabien : \" Spuck ' Geld frei \"", "Melania Trump holt sogar Eltern Hilfe", "Restaurants : Wien : 13 Restaurants", "Tr\u00e4nen : Kate liest Prinz George Hochzeit Leviten", "Pippa Middleton : Gr\u00fcnde Trennung Nico Jackson", "Erneut Sorge Unabh\u00e4ngigkeit polnischer Gerichte", "Brustkrebs : \" wusste , Handeln angesagt ! \"", "Leben Brustkrebs : sagen Experten", "Verschollenes U-Boot : Argentinische Marine pr\u00fcft Ger\u00e4usch Meer", "Extremer Film : \" wahre \" American Sniper Chris Kyle", "Thiem scheidet Paris-Achtelfinale", ": Ben Marecek", "Sch\u00fcsse Diskothek Konstanz", "Franz\u00f6sische Filmlegende Jeanne Moreau tot", "Deutschland - Langeweile Wahlkampf : Sieger fix , Ergebnis", "Rosie O \u2019 Donnell spricht Whitney Houstons lesbische Beziehungen", "St. P\u00f6lten : Trauer SP-Gemeinderat Pressesprecher", "Wien : Neues Restaurant levantinischer K\u00fcche", "Maduros \" Stra\u00dfenkinder \" : Fl\u00fcchtlingskrise", "Schminkschule : lassen Schlupflider kaschieren", "Lehre durchstarten", "Mangelberufe : Lehrlinge dringend gebraucht", "tote L\u00e4mmer heizen   Diskussion Wolf neu", "Restaurants : Wien : Top 4 : Ramen-Lokale", "Hauptspeise : Rinderfilet weihnachtlichen Gew\u00fcrzen Rosmarien-Reiberdatschi , Palmherzen Pilzen", "Pendler planen Fahrgemeinschaften via Facebook Apps", "Glawischnig : \" Kinder lasse Heinz Fischer warten \"", "Revolution anpassen ? Freiheit !", "Unruhestifter", "Lebenslang dauert \u00d6sterreich Schnitt 21", "Telekom : l\u00e4stige K\u00fcndigung", "Chris Martin liebt beste Freundin Ex Gwyneth Paltrow : Charlize Theron", "Manson-Mordserie : Anh\u00e4ngerin Leslie Van Houten Begnadigung", "Diskussion Bedeutung Cholesterin", "Nordkorea : Bev\u00f6lkerung Milit\u00e4r hungern", "Maroni : Gesund : Maroni Herbst & Winter", "USA : Bel\u00e4stigungsvorwurf Actionfilmstar Seagal", "FAQ - Frequently Asked Questions", "Rudolfstiftung : \" Rausschmiss \"", "\" Fl\u00fcchtlingsarbeit zache Gschicht \"", "alter Querulant erinnert goldene Zeiten", "\u00d6VP erh\u00f6ht Druck SP\u00d6 Islam-Gesetz", "Facebook : Paradies Schmutz-Wahlkampf", "Leserbrief Artikel \" eigentlich Alexander Van Bellen ? \"", "Insolvente Gro\u00dfw\u00e4scherei Sanierung Fortbetrieb finanzieren", "Entspannung ,", "Populismus : Vorsatz", "Hei\u00df , hei\u00dfer ,   Kroatien", "Salzburg Guimaraes Aufstieg fixieren", "Salzburg-Nachwuchs Youth-League-Play-off", "Rapid 2019 Schobesberger z\u00e4hlen", "Umfrage : Kreuzwortr\u00e4tsel", "Vorschlag gekippt : Klares Saatgutverordnung", "EU-Verordnung : bio ?", "Osteuropa \u00dcberholspur", "RBI w\u00e4chst \u2013 vorsichtig", "Neues Gesetz \u00f6ffnet   T\u00fcr Bordelle", "Gebiete Stra\u00dfenprostitution", "H\u00f6hle L\u00f6wen : investiert Po-Dusche ?", "Florian Holzer : Top 5 : Westautobahn", "Lokale Autobahnen : Schloss Hochhaus , Wirtshaus D\u00f6llerer , Sicher , Steirerschl\u00f6ssl , Haberl & Fink 's", "Inklusion : Kinder Behinderung Regelschule integriert", "Ertrag & Sicherheit : Verm\u00f6gensberater hohe Spesen verschwiegen", "Musikantenstadl : Show Andy Borg : \" Andy \"", "Doppelmord Stiwoll : \" Hinterher gescheiter \"", "FP\u00d6-Demo Fl\u00fcchtlinge : wahre Geschichte Bildes", "Pro & Contra : Gesamtschule - KURIER-Autoren Lehrer diskutieren", "Englands k\u00f6nigliche Familie : Stammbaum Familie Windsor", "essen Weihnachten ?", "Drama Bike-Profi : \u00c4rzte sagen \" Geduld ! \"", "Kurz-Auftritt : ORF bittet Meissnitzer Gespr\u00e4ch", "Umfrage : FP\u00d6 K\u00e4rnten nahe 30 Prozent", "Wei\u00dfe Z\u00e4hne - Folgesch\u00e4den ?", "Erwin Schrott vergoldet \u2013 Ehrung Opernstar", "Michael J\u00e4ger neuer stellvertretender Chefredakteur KURIER-Medienhaus", "\u00d6sterreich Wiener Schnitzel Apfelstrudel", "Langj\u00e4hriger XXX-Lutz-Gesch\u00e4ftsf\u00fchrer Seifert gestorben", "vierfache Kanzler-Gage", "subjektiv beste Gulasch Welt", "Restaurants : Saison begonnen : Gansl-Restaurants", "Wohnen Kaiser", "Gr\u00e4tzlhotel : Schlafen Auslage", "OMV treibt Iran-Gesch\u00e4fte voran - Absichtserkl\u00e4rung Dana Energy", "Teams Stunde : Lauf", "\" Problem ideologischen Schubladen \"", "Demos Rechts : \" Mobilisierung \"", "Hausaufgaben Familienkrise", "Mordverd\u00e4chtiger Rocker : \" Verr\u00e4ter \" offenbar enttarnt", "EU-Tabakprodukt-Richtlinie", "Erwin Javor : \" Denken \u2013 erlaubt , erw\u00fcnscht \"", "O\u00d6 : Junger Mann stach Streit Freundin", "USA : Missbrauchsdoktor bekannte schuldig", "T\u00fcrkei verurteilt angebliches Abkommen IS-K\u00e4mpfern Raqqa", "\" Friedrich M\u00fcller\"-Betreiber erh\u00e4lt 2,5 Haft Betruges", "Anklage Abzocker \" Friedrich M\u00fcller \"", "fotografischen Anf\u00e4nge Wien", "Bodyblog : Federleicht Bungee-Training", "Schauspielerin Ursula Strauss Interview Rollenspiele", "8 Tipps : Besondere Christkindlm\u00e4rkte \u00d6sterreich", "Musik Mozart Epilepsie-Anf\u00e4llen vorbeugt", "Florian Holzer : Top 5 : Pizza-Projekte", "Leonardo DiCaprio Rihanna Schmusen erwischt", "Heer versetzt FP-Chef Reservestand", "Arnold Schwarzenegger besuchte \u00d6sterreich Kreisel Electric spielt Domorgel", "Zara Home , Pull & Bear , Glash\u00fctte , Pandora : 5 Stores Wien", "Rituals NYX : Donauzentrum r\u00fcstet Beauty-Stores", "BP-Wahl : Hofer Kornblume verzichten", "Sky \u00d6sterreich adverServe arbeiten", "Adworx Tunnel23.com vereinfachen Arbeitsalltag", "? Hashtag # metoo entfacht Sexismus-Debatte", "Adam sucht Eva : Patricia Blanco zieht blank", "Wehleidigkeit rettet", "LEBEN : Guido Tartarotti Schlaf , Abst\u00fctze Witz Welt .", "Frauen \u00d6sterreich M\u00e4nnerwelt", "Moskau trotz   Krise herausputzt", "Lorenz Gallmetzer : Weg Alkoholsucht - heraus", "Dieter Meier Yello : Hits Uhren \u2013   zugeflogen", "Handel : KURIER-Magazin \" Schreiben \"", "Leben Pr\u00f6lls : \" Mann charmanter \"", "Erkrankungen : Grippe-Saison begonnen", "Mordverdacht : Beschwerde Aslan G. Auslieferung Russland", "Droge : Experten warnen \" Bonzai \"", "Praterstern : \" Held \" Massenschl\u00e4gerei bedroht", "ORF-\"Vorstadtweiber \" : D\u00f6blinger Boutique Auslage", "Bad Gastein : \u201e Monaco Alpen \u201c br\u00f6ckelt", "Achtung , Touristenfalle ! Geldwechseln z\u00e4hlt", "Red Bull K\u00f6rper passiert", "kriminell Ausl\u00e4nder", "Statistik Austria droht Strafe", "\u2005 Baustelle Belastung", "  \" Quick \" sorgt Probleme", "HC Strache Philippa Beck geheiratet", "KW35 : Social-Media-Wochenr\u00fcckblick", "eins Kurz-Programms", "Waterdrop : Gesund Vitaminwasser : ?", "Manukahonig : teure Honig bringt", "Hygge-Trend : D\u00e4nen gl\u00fccklich", "Globalisierungskritiker Jean Ziegler : \" Weltkrieg l\u00e4uft l\u00e4ngst \"", "Millionen-Pleite Sanatoriums Rupp St. Georgen", "Pr\u00fcfer kritisieren Finanzierung   Krankenhaus Nord", "Mythos Krebs : stimmt ?", "Victoria 's Secret stellt BH 2 Mio. Dollar", "Toto Riina , Nummer eins Mafia , tot", "Hofer : \" Agenda \"", "EU marschiert Richtung Verteidigungsunion : bedeutet \u00d6sterreich ?", "Fendrich-Musical : Au\u00dferhalb Austrias nix fix", "Arbeiten Tod", "Karim Aga Khan : menschlichen Schw\u00e4chen", "\" King of Queens\"-Stars", "Geheimtreffen Strache", "N\u00d6 : ICE-Unfall schlechten Deutschs", "Karas : Schelling bremst Kampf Steueroasen", "Bundesheer bekommt betr\u00e4chtliche Finanzspritze", "Midi-Pyr\u00e9n\u00e9es : franz\u00f6sische Toskana", "Kern : Finale Freundlichkeiten", "U6 teilweise gesperrt : Polizeieinsatz Michelbeuern", "Isla Bonita bringt fettreduzierte Avocado Markt", "Gaiger : KURIER online Top-Drei", "Glyphosat : Gesch\u00e4fte Umweltschutz", "Sport-Talent 15 : Steffi Grafs Sohn Jaden Agassi", "\u00f6sterreichische Paare gl\u00fccklich", "\" Job , anrufen \"", "Fotos offenen T\u00fcr", "Franz\u00f6sischer Spitzenkoch Sebastian Bras Michelin-Sterne abgeben", "Yoko Ono friedfertig : Rechtsstreit \" John Lemon \"", "Alfons Haider trennt Freund", "Pilz : Staatsanwaltschaft pr\u00fcft Strafbarkeit", "Millionengesch\u00e4ft   Verkehrsstrafen : Einnahmen Strafen Verkehr verdoppelt", "Sebastian h\u00f6rt : Partie T\u00fcrkis Sagen", "PISA-Studie : \u00d6sterreichische Sch\u00fcler Team-Probleml\u00f6ser", "\" Seiler & Speer \" : Schwerer Unfall Bernhard Speer", "Kredite : holen \u00fcberh\u00f6hte Zinsen \u2005", "Pflege   Heim schnappt Verm\u00f6gensfalle gnadenlos", "  Pralinen-Giftkrimi", "gef\u00f6rderte Wohnung vermieten ?", "\u00dcbergriff Badesee : Polizei fahndet Sittenw\u00e4chtern", "Gault&Millau : Markus Mraz Koch Jahres 2018", "Malia Obama : Alk-Party Amsterdam", "Belvedere-St\u00f6ckl : Bezirk fordert Schutz Anrainer", "Fu\u00dfball : \u00d6FB-Frauen siegten WM-Quali 2:0 Israel", "Eiwei\u00df : Linsen , Bohnen & Co. : pflanzliches Eiwe\u00dflieferanten", "UNO-Soldaten Fronten s\u00fcdlichen Libanon", "Wachauer Marillen : Bauern rechnen Bomben-Ernte 2017", "Schlierenzauer : \" eigentlich ? \"", "AC/DC-Mitbegr\u00fcnder Malcolm Young gestorben", "Donaukanal-Spirit", "Gstettn Lieblingsplatz", "Kaffees : Caf\u00e9s Wien", "Copa Cagrana gr\u00f6\u00dfer   pr\u00e4sentiert Bobo-Stil", "veganen Sorten Ben & Jerry 's", "gewonnener Unterlassungsklage Duzdar Strache : FP-Chef zahlt 12.000 Euro Frauenh\u00e4user", "Heilungskr\u00e4fte Muskeln", "Ewan McGregor : 5 Fakten sch\u00f6ne Tochter", "Krampusl\u00e4ufe : ausgelebte Aggression", "Pensionen : \" K\u00f6nigsweg l\u00e4ngeres Arbeiten \"", "Konditoreien \u00d6sterreichs", "Fu\u00dfball-Bundesliga : Philipp Schobesberger verl\u00e4ngert Rapid 2022", "Star Porno-Film", "M\u00e4nnerschnupfen : Mythos ?", "k\u00fcndigen", "Xmas-Opening : Promis holen Deko-Ideen", "Heeres-Helikopter abgest\u00fcrzt : Opfer klagt", "Miete Kaufoption : G\u00fcnstiges Angebot teure L\u00f6sung ?", "Blaue Verhandler : Irritationen Strache Haimbuchner", "Kira Gr\u00fcnberg Kurz-Team", "Kira Gr\u00fcnberg : \" Sprung neues Leben \"", "Geduld Ausl\u00f6ser", "Florian Holzer : Top 5 : Fischlokale Wien", "Frei gebunden : Zukunft Liebe", "Live-Stream ROMY : Stars Red Carpet", "ROMY 2017 : Kleider Stars", "M\u00fcnzen Geldanlage : Investieren Gold Niob", "Aktionstage Politische Bildung : Elefantenrunde - politisches Kartenspiel", "Vergleich : kostet 1 Arbeitsstunde", "Weltmuseum : l\u00e4uft Er\u00f6ffnung , Haus", "Sprache : \" Asylantenflut \" unseren K\u00f6pfen", "Eigent\u00fcmer-Wechsel & Folgen Mieter", "Tschechien : Arbeitskr\u00e4fte verzweifelt gesucht", "Fanfare schmeckt", "Mugabe-Regime Land herunterwirtschaftete", "Levi-Slalom : Marcel Hirscher Comeback 17 .", "\" Aktion 20.000 \" - Jobs \u00e4ltere Langzeitarbeitslose", "Shermine Shahrivar Lapo Elkann : Fotos Liebesurlaub", "Wien : Restaurants Weihnachten", "Rapid : Dokupil startete Djuricin", "Rapid : Djuricin offiziell Cheftrainer nennen", "Tirol Fall Larissa : Junges Liebesgl\u00fcck endete t\u00f6dlich", "Schulschw\u00e4nzen : Eltern Gef\u00e4ngnis 440 Euro Strafe zaheln", ", feine Skigebiete \u00d6sterreich", "Lehrer-Aufnahmetests :   Deutsch Stolperstein", "Mindestpension : 30 verdient , bekommt 1000 Euro Pension", "Goldi heiratete Astrid", "Lawrence : Peinliche Fragen Kim Kardashian", "Hofer : \" SP\u00d6 Gl\u00fcck zwingen \"", "\" Abgrundtief aberwitzig bl\u00f6dsinnig \"", "Sch\u00f6nheitswahn ? Kate Hudson Goldie Hawn", "50-Prozent-Anstieg \u00d6lpreise Sommer steckt", "Giulia Enders Interview : \" Darm Charme\"-Autorin bekommt Oberhummer-Award", "Wien : Scheidung Gericht endet Schl\u00e4gerei", "Wiener Buchhalterin zweigte Geld : Prozess", "Medizin-Mythen : Hemmt Graviola Krebswachstum ?", "Rezepte : 15 erfrischende Rezept-Ideen Hitze", "RZ-Holzindustrie : Brisantes Nachspiel S\u00e4gewerks-Pleite", "Christian Qualtinger : \" Herr Karl \" Helmut Qualtinger Comic-Buch", "Kern d\u00fcrfte Gusenbauer k\u00fcrzestdienender Kanzler abl\u00f6sen", "Harter Job   OMV-Finanzchef", "Austria Wien : Chaos Nachspielzeit", "\u00d6VP-Chef Sebastian : TV-Interview Wahl kurier.at", "Harvey Weinstein : Quentin Tarantino bricht Schweigen", "Tansania : Kraftpl\u00e4tze Christine Wallner", "Tansania : Hilfsprojekte Christine Wallner", "Kilimandscharo : Luxus-Lodge Selbstversorger-H\u00fctten Christine Wallner", "Polizeibeobachtung : Land Rocker zukunftsreich", "Rockergangs Vormarsch : Hells Angels greifen \u00d6sterreich", "Larry Flynt bietet 10 Mio. Trumps Amtsenthebung", "Studie warnt Einfluss Muslimbruderschaft \u00d6sterreich", "t\u00e4gliche Turnstunde bringt", "T\u00e4gliche Turnstunde knapp 500 Schulen ausgeweitet", "Linzer SP\u00d6 : Fl\u00fcchtlinge Mindestsicherung nehmen", "Ohrwaschl : W\u00f6d-Wampeler", "Kulturerbe pures Gold wert", "Wilde T\u00e4nze ROMY After-Show-Party", "Tennis-Traumpaar : Dominic Thiem liebt Kollegin Kristina Mladenovic", "Konkurs Wiener Cafe Leopold er\u00f6ffnet", "Fr\u00fchst\u00fcck Karlheinz Hackl Maria K\u00f6stlinger", "Kommentar Chaos", "Mann Schusswunde Wien-Brigittenau Gehsteig gefunden", "T\u00fcrkei-Referendum - Reportage Ottakring : \" Evet is ' , brauch ' ma net \"", "Frontalzusammensto\u00df zweier Pkw : 21-J\u00e4hrige tot", "Skifahren : 's erfunden ?", "Fu\u00dfball : Diplomatische Verstimmung Eklat Chinas U20-Premiere", "Sch\u00f6nheitswahn Seele antun", "Beauty-Tipps : Frauen langen Haaren nachts", "besessen Heath Ledger \" Joker \"", "Psychotest : Hilfe annehmen ?", "Schule Not : schaffen", "Bildung Not : \" Geld brauchen \"", "Wien : Chinesischer Supermarkt Antibiotika verkauft", "Wien : Gefl\u00fcchteter Strafgefangener Polizei Netz", "Florian Holzer : Top 5 : Restaurants Piste", "Mazedonien : Sturm Parlament 23 Journalisten verletzt", "Ernst August jr. & Ekaterina Malsheva : Traumhochzeit Hannover", "Angeschossener Doppelm\u00f6rder laut Justiz \" psychisch gesund \"", "Immo-Gruppe PEMA engagiert Ex-Kanzler Faymann", "Kern-Leaks : Gusenbauer klagt \" \u00d6sterreich \"", "Gusenbauer : Steile   Erfolgskurve Kapitalist", "Crowdfunding : Massiver Anstieg Investitionen", "Rasches Joggen", "Flughafen Wien bekommt Office Park", "27-J\u00e4hriger stellte Mord Linz", "Mord Linzer Lokal : R\u00e4tsel   Identit\u00e4t Mitt\u00e4ters gel\u00f6st", "Neues Restaurant : Wien : Caf\u00e9 S\u00fcssmund er\u00f6ffnet", "Knalleffekt : Ruttensteiner , Sch\u00f6ttel folgt", "H\u00f6rbiger : \" Motor Paarbeziehung \"", "Liebe Barbara Becker", "Emma Bonino Fl\u00fcchtlingskrise Italien", "Personal : Karl Schillinger Gasthaus Schillinger Gro\u00dfmugl zusperren", "Prominente f\u00fcrchten Hotel Sauerhof", "Men\u00fcs McDonald \u2019s st\u00f6\u00dft Kunden sauer", "Werner Herics neuer Landesdirektor", "Spitze ORF-Burgenland ?", "\u201e Mr. Netrebko \u201c  ", "Anna Netrebko Duo Rolando Villaz\u00f3n", "Netrebko : Jubel , Arie singt", "H&M verbrennt tonnenweise Kleidung", "Schwierige Zeiten Moscheen", "Deutschlehrer protestieren   Wertekurse Integrationsfonds", "paar Bilder Begegnung Poly-Sch\u00fcler_innen Staatssektret\u00e4r", "Kabinett Kurz-Strache Chancen", "voestalpine : Weltmarktf\u00fchrer mal", "Texas : Voest er\u00f6ffnet neues Werk USA", "Voest droht Abwanderung USA", "Bundesliga : Austria holt norwegischen St\u00fcrmer Ola Kamara", "Kreuzfahrt Privatinsel : Sorglos Sonne Karibik", "5 Lebensmittel , Eiwei\u00df H\u00fchnerfleisch", "Wien : Gesamter Volkshilfe-Betriebsrat Posting entlassen", "Karmasin Uni Kinderg\u00e4rtner", "Jesper Juul : Tipps verzweifelte Teenager-Eltern", "Tom Cruise Suri Leben \" verbannt \"", "Steuerpolitisches \u201e Haxerlstellen \u201c", "Welt vegan ern\u00e4hren ?", "\u00dcberlastung Pflege : Angeh\u00f6rige Limit", "Milit\u00e4r \u00fcbernimmt Kontrolle Simbabwe dementiert Putschversuch", "RunNa : mal off", "RunNa : Did not finish is Option", "RunNa : Verstopfte Kan\u00e4le , gerissene B\u00e4nder", "Skigebiet Star Youtube", "Gernot Schieszler - Bu\u00dfe Haft : \" M\u00e4dchen \u201c", "Innsbruck : 14-J\u00e4hrige offenbar Stiegenhaus vergewaltigt", "Arbeitssuche 50plus : Jobs Alterslimit", "Meghan Markle : h\u00e4lt Queen Harrys Neuer", "Infografik : Zucker enthalten Energy Drinks ?", "Energy Drinks : EU-Kommissar Gefahren   koffeinhaltigen Muntermachern pr\u00fcfen", "Kurier digital-Verkaufsteam neu formiert", "Schelling : Bewerbung Eurogruppenchef l\u00e4uft 10", "Mick Jagger : 72 Mal Vater", "Niemetz Schwedenbomben Ecker & Partner", "Pflege : Missst\u00e4nde 24-Stunden-Betreuung", "\u00d6sterreicher beschenken Durchschnitt Weihnachten Personen", "Kevin Spacey : \" House of Cards\"-Mitarbeiter erheben Vorw\u00fcrfe", "R\u00fcckzug Veranstalters : Zukunft \" Rock Vienna \" ungewiss", "Kulissen- berufspraktische KURIER", "KURIER \u00fcbernimmt SchauTV", "Letzte Hoffnung Ex-Bawag-Chef Elsner", "Richard Drasche-Wartinber : Pardon Baron", "Griensteidl : Caf\u00e9-Legende", "Sexistische Kommentare , k\u00fcnstlerisch interpretiert", "Leonardo DiCaprio : Kabbala Trennung", "Tod : \" Gestorben \"", "13 Reasons Why : Netflix : US-Serie : Teenager Gefahr", "Bayern : Horst Seehofer Markus S\u00f6der k\u00e4mpfen", "Eiskunstlauf : halb Wien Fernsehern sa\u00df", "Angelina Jolie : sagen Chirurgen Nase", "WGKK : Fahrtendienst Krankenwagen", "Helga Rabl-Stadler , Bo Skovhus , Salzburger Festspiele , Louis Roederer , Reims , Paris", "Restaurants : Bars : Wien : Dachterrassen-Bars", "Wien : 5 Restaurants", "\u00d6VP-Abgeordnete Gr\u00fcnberg bekam Opel Insignia geschenkt", "Leserbrief :   \" Bilder glauben . \"", "Krypto-W\u00e4hrung Bitcoin durchbricht erstmals Marke 5.000 Dollar", "Polizist Uhudler-Fan", "Christian Kolonovits Wiener Musical : \" Subventionsorgie \" Familienbetrieb", "Dumpfbacken ber\u00fchmt   - ? Christina Applegate Matt LeBlanc", "Dumpfbacken TV - einst", "\" Battle of the Sexes \u2013 Regel \" : Tennismatch Feministin Macho", "Ausbrecherk\u00f6nig Adolf Schandl : \u201e : ,   stirbst Gef\u00e4ngnis \u2019 \u201c", "\" gelernt PSA-Test umzugehen \"", "Urologe Anton Ponholzer verr\u00e4t Gesundheitstipps", "Maler Frauen \u2013 Muse , Aff\u00e4ren", "Tex Rubinowitz - Karikatur TV-Programm", "Tex Rubinowitz : Rumgurken Welt", "Mediadaten 2014", "Glyphosat : Wahlkampf giftigen Argumenten", "Julius Meinl V. erh\u00e4lt 90 Millionen Rekordkaution", "Franziska Meinl Alter 53 verstorben", "Bericht UNO deckt unvorstellbare Gr\u00e4uel IS Kindern", "   Olympia-Kaplan", "Milliarden-Koloss Olympia 2012", "Media-Analyse : KURIER stabiler Reichweite", "KURIER punktet Top-Zielgruppen", "Abstimmung : Gitarristen", "Rolling Stone : Gitarristen", "Yoga Schwangerschaft : Buch : Katharina Rainer-Traw\u00f6ger", "Hot Yoga : gesund ?", "Graz : Kastenwagen \" Heil Hitler\"-Transparent", "Sch\u00fcsse N\u00e4he Graz : Tote", "Wien : Nikab-Streit offener Stra\u00dfe", "\" Heil Hitler\"-Kennzeichentafeln weiterhin verboten", "Outing Schule : Plakatserie", "\" Willkommen Hartmanns \" Akademietheater : Fl\u00fcchtlingskrise Gesellschaftssatire", "Hahnenkammrennen : Promis Kitz Race Night 2017", "Doping : D\u00fcrrs Schwiegervater ger\u00e4t Visier", "Schatten Licht Langlauf-Horizont", "LP : \" Lesben geben . hinweg ! \"", "Traurige Welt : Lachen Weinen", "Peter Cornelius 65 : entschuldige , m\u00f6gn di !", "Freundin verr\u00e4t Dianas wahre Liebe", "Kroatien Sonne", "Fenderl & Assinger : Paarungen", "L\u00e4nderspiel Teamchef Franco Foda", "Zollunion vervierfachte Handel EU T\u00fcrkei", "Kern h\u00e4lt Ausweitung Zollunion EU-T\u00fcrkei undenkbar", "350.000 Euro Strafe \u00d6BB Unfall", "Bahnhof Meidling : Z\u00fcge kollidiert", "Spitzenlokale Michelin-Sternen Italien", "Strindberg-Weg sch\u00f6nsten Burg \u00d6sterreichs", "Herz schl\u00e4gt \u00d6sterreich", "Oststeirisches Energie-Start-up Neovoltaic meldete Insolvenz", "FP\u00d6 Sprung Regierung", "Mila Kunis extrem abgenommen : Hungert Ashton ?", "Sommer-Grand-Prix : Gesichter Hinzenbach", "1000 Dinge , Wien", "Rettet   Krampus : \" tut nix \"", "Klassenkampf Streifenhaus", "Schweiz : Hanf-Zigaretten Supermarkt", "Auersperg-Breunner : K\u00e4mpferische Prinzessin", "S.T.S.-Urgestein Gert Steinb\u00e4cker verr\u00e4t Hotspots Korfu", "VwGH bescheinigt E-Control Unabh\u00e4ngigkeit", "Raiffeisen Ware Austria : Einfamilienhaus , errichtet Lagerhaus", "Schweizer Bell baut Marchtrenk neues Werk Fertiggerichte", "Gerhard Berger , Helene , Tochter , Schwangerschaft , Kitzb\u00fchel , Almsommerparty , Vater , Rasmushof , schwanger", "Rapid - Innsbruck Nachlesen", "Anne : Vermummungsverbot \u00f6ffentlichen Dialog", "Golf meistverkaufte Auto", "Philippinen : Duterte Pr\u00e4sidenten gew\u00e4hlt", "Philippinischer Trump ? Wahlsieger Duterte Zitaten", "Sido echter Wiener", "Jeann\u00e9e vs. Sido : \" Hodenhalter \" \" Hausmeister-Bua \" ...", "Dario Maresic : jugendlicher Dauerbrenner", "Kunst , Lupe     Smartphones betrachtet", "\" Hanner \" Mayerling sperrt", "Bildungsreform : pr\u00e4feriert FP\u00d6-Variante", "Bildungsreform : \" Bildungspflicht \" 18", "Vulkan Bali : 50.000 Flucht", "Service Komfort Ertrag", "Nicole Kidman spricht Ehe Tom Cruise", "Elektroautos Stromverbrauch \u00d6sterreich Siebentel erh\u00f6hen", "Drum pr\u00fcfe , ewig bindet", "Thunfisch 566.000 Euro versteigert", "teuerste Pilz Welt", "M\u00fcnchendorf - B\u00fcrgerinitiative l\u00e4uft   geplanten Windpark Sturm", "Unabh\u00e4ngigkeit erkl\u00e4rt : Katalonien-Krise spitzt", "\u00f6fter st\u00f6ren Gaffer Unf\u00e4llen", "Weg Rohdachboden Wohnungsjuwel", "1,741.246 Einwohner : Wien zweitgr\u00f6\u00dfte deutschsprachige Stadt", "Oberkrainer-Volksmusiklegende Slavko Avsenik tot", "ticken \u00d6sterreichs Jugendliche", "Jung politisch : junge erz\u00e4hlen , politisch engagieren", "Neuer Austrian Airlines Flug Havanna", "Manfred Deix ' \" Ostergeschenk Kirche \"", ": 12 Fragen Haubenkoch Toni M\u00f6rwald", "Toni M\u00f6rwald : \" Verbote verbessern \"", "\u00dcbergewicht Jugendlichen : \u00d6sterreich mitteleurop\u00e4ischen Trend", "Rollentausch Wahlaufhebung : H\u00f6chstrichter Beklagter", "Ex-FP\u00d6-Justizminister Michael Kr\u00fcger spendet \u00d6VP-Liste 5000 Euro", "Bobo-Partei", "Hinweise Amtsmissbrauch Verkehrsministerium", "SP\u00d6-Programm Nationalratswahl 2017 : \" hol , zusteht \"", "SP\u00d6 beerdigt ihren Slogan \" Hol , zusteht \"", "Wien Museum : parkt Bruno Kreiskys Rover", "Impressionen Depot Wien Museums", "Merkur-Verleihung : Lauter Einser Streberin", "Neuer Bundesschulsprecher Maximilian Gnesda vertritt 1,2 Mio. Sch\u00fcler", "Video : zeigt Sebastian private Seite", "Jennifer Anistons : Aussehen", "Mindestsicherung Faktencheck : \" trifft Fl\u00fcchtlinge \"", "Vertrauen   \u00dcberbeh\u00fcten : Europ\u00e4er Erziehung", "b\u00f6se : wirkt Sonne", "Heidi Strobls Rezept Woche : Rump Steak Salzstein gegrillt", "Dominique Meyer : \"   gerne geblieben \"", "Heimliche Begleiter", "Fr\u00fchst\u00fcck Dagmar Koller", "Infografik : Lachen gesund", "positiven Effekte Humor", "HC Linz sucht Nachfolger Chefcoach Adzamija", "\u201e gehe weg \u201c", "Ungereimtheiten Pleite Gulliver \u2019s", "Emilie Fl\u00f6ge : Coco Chanel Wien", "sieht Griensteidl", "Florian Holzer : Top 5 : Gastg\u00e4rten Wien", "Kriminalit\u00e4t : Tatverd\u00e4chtigen", "Milana Gr\u00e4fin Abensperg : Frisches Blut \u00d6sterreich Royals", "Schul-Guru Salcher:\"Neun Wochen Sommerferien   \"", "Weihnachtsfeiern anziehen", "H\u00e4ssliche Weihnachtspullover erobern \u00d6sterreich", "Austria l\u00e4uft Milan Heimdebakel", "gef\u00e4hrlich Zahnr\u00f6ntgen ?", "WEGA : M\u00e4nner Sturmmasken", "WEGA-Einsatz Wien-Liesing : Elite-Polizisten Visier Justiz", "Versandapotheke startet \u00d6sterreich", "Kaiser Franz Joseph : \" blieb erspart \"", "Schicksalsstunden", "Jamiroquai Wien : Funk-Party Sp\u00e4tz\u00fcnder", "Prokrastination : Aufschieben krank - Forscher sagen", "Joseph Brot er\u00f6ffnet B\u00e4ckerei Bagel-Shop Wiens", "Millionen-Erbschaft : Bundesl\u00e4nder verklagen Aiderbichl-Stiftung", "Kim Kardashian best\u00e4tigt Baby Nummer", "Herd Moderatorin Barbara Karlich", "Nachfolge Erwin Pr\u00f6ll : Latte liegt - \u00f6sterreichweit Absolute halten", "Peter Kraus : Komplikationen \" bl\u00f6dsinnigem \" TV-Unfall", "Ludwig Wittgenstein : Fliege Fliegenglas", "Homeshopping-Lady Portrait : tickt Donald Trumps Frau Melania . Biografie", "George Clooney Schauspieler : Geld schlechte Rollen", "Afghanische Sch\u00fclerinnen erhalten US-Visa", "Messerattacke M\u00fcnchen : Polizei mahnt daheim bleiben", "Bushidos Frau Trennung Polizeischutz", "Titel LASK-Nachwuchs", "Wirbel Idee Umweltbundesamts 2020 E-Autos verkaufen", "Charlotte Casiraghi & Prinzessin Alexandra stilsicher Pariser Fashion Week", "Tierarten eher gef\u00e4hrdet", "Fr\u00fchst\u00fcck Erni Mangold", "Mindestsicherung KURIER-Faktencheck", "Mindestsicherung \u2013 einfach erkl\u00e4rt", "Chuck Norris verklagt Pharmafirmen : \" Frau vergiftet \"", "Vergewaltigung Versuche Linz : 21-J\u00e4hriger gefasst", "Maturantin Linz vergewaltigt - Anklage erhoben", "\" Big Bang Theory \" : Bernadette l\u00e4sst H\u00fcllen fallen", "Mama : Kinder", "Global 2000 warnt : \" Schale Verzehr geeignet \" stimmt", "Pl\u00f6tzlich Weideland   30 Millionen Euro wert", "Saudi-Prinz 300 Millionen Dollar \u00d6sterreich parken", "N\u00e4chster Minister-R\u00fccktritt ersch\u00fcttert London", "Wahl 2017 : Hochrechnungen", "Moretti Trenker : \" Wichtig , \"", "Rekordflug : L\u00e4ngster Linienflug Welt fliegt nonstop Doha Auckland", "Frau \u00fcbernimmt Top-Funktion Heer", "Flughafen Schwechat : Restaurants : Jamie Oliver Wien", "Brennstoffzellenauto Zukunft", "Hans Moser : Nuschler", "Celine Dion : Schwester Krebs diagnostiziert", "Ex-Krages-Chef Schnedl Geld Ehre", "75 Seiten fristlose Entlassung", "Umfrage : Migration Thema Nr. 1 \" offene Flanke \" SP\u00d6", "Metropolen Zukunft : Buenos Aires , Vielseitige", "Spital verdienen", "Headhunter : Suchen Kandidaten , Ecke denken", "wissen Nobelpreis ?", "Salzburg : Neuer Eremit Einsiedelei Saalfelden gefunden", "Hacker zockten Lauda", "Ansichten unterwegs : Bewegte Geschichten Richard Hollinek", "Neuer Mann Seite C\u00e9line Dion", "Wolfgang Loitzl beendet Skisprung-Karriere", "Ozzy Osbourne : packt Aff\u00e4re", "\" zusehen , Babys Dreck schlafen \"", "Science Fair Sacre Coeur , 2017", "Melania Trump umschw\u00e4rmt Prinz Harry", "Schlag Henssler : Blamage Steffen Henssler", "450 Polizisten Demos Kahlenberg", "MyTaxi faire Uber", "Steirischer Fleischer f\u00fchlt Dialekt-Video Youtube verleumdet", "Jobs Klasse Langzeitarbeitslose 50", "\" Aktion 20.000 \" : Jobs , gebraucht", "Medizin-Mythen : pflanzliches Eiwei\u00df ges\u00fcnder tierisches ?", "Medizin-Mythen : Hilft Schr\u00f6pfen R\u00fcckenschmerzen ?", "R\u00e4tsel Tages : Fehlersuchbild", "Bekannte Kaffeehausbetreiber stolpern Konkurs", "Top 10 Attraktionen Yellowstone Park : sch\u00f6nsten Pl\u00e4tze Nationalpark", "Pikante Pleite Zeitschriften-Verlags", "Gault Millau : Richard Rauch Koch Jahres", "Chili Peru : Erich Stekovics z\u00fcchtet teuerste Gew\u00fcrz Welt", "Ski alpin : Schock Trauer Tod David Poisson", "Karlsbad , Marienbad Franzensbad : Nostalgie b\u00f6hmischen B\u00e4derdreieck", "Wow : Ronaldo zeigt Luxus-Spa", "Muslime Katholiken Wiener Pflichtschulen", "  Glauben fand", "AMS Wien l\u00e4dt \" hr-lounge \"", "Nordkorea-Wasserstoffbombe ersch\u00fcttert HTL Hollabrunn", "Schlossherr , selber putzt", "Schafft K\u00fcndigungsschutz", "\" \u00d6sterreich fangen   null \"", "Ingrid Flick pr\u00e4sentiert neues Buch", "Erkenntnisse Bienensterben", "Jacqueline Kennedy Glanz Trag\u00f6die", "Cyber-Kriminalit\u00e4t Bedrohung Banken", "Teure Telekom-Altlast St. Marx", "Kritik Plan St. Marx :   \" Stadt Holzweg \"", "meinKauf-Projektleitung Amashaufer", "Schnupfogusch !", "Marterpfahl", "Millionen-Pleite Questers Feines", "Steirischer Arzt Gericht : Vorl\u00e4ufiges Berufsverbot", "Geschichte Zuwanderung : Woran Gastarbeiter erinnern", "Mann verpr\u00fcgelt : \u201e Woche fast tot \u201c", "Pippa : Meghan Markle Hochzeit fernhalten", "Busek Bl\u00fcmel Streitgespr\u00e4ch : \" \u00d6VP Begr\u00e4bnis bestellen \"", "Haus Geschichte N\u00d6 : Museum Wachturm", "Bananen Fr\u00fchst\u00fcck eignen", "braune Bananen essen", "Deutschland : 267.000 Euro   Alarmanlage       Tochter", "\u00d6konom Sutter : \" geduldig , Erfolg \"", "Geduld liegt Karriere", "8 . Dezember : Fast Gesch\u00e4fte Feiertag", "Peter Pilz sexuelle Bel\u00e4stigung vorgeworfen", "\" 20 Hasardeur \"", "Spotify meldet 50 Millionen Abo-Kunden", "Miss World Indien", "Medikamenten-Engp\u00e4sse zunehmen", "Geheimnisse erholsamen Nachtruhe", "J\u00e4nner 2017 k\u00e4lteste 30", "\" Verdienen dienen \"", "Terence Hill verr\u00e4t Fitnesstipps 77", "schwerem Autounfall : Bernhard Speer Tiefschlaf", "Sonja Kirchberger heimlich verliebt", "Bakterien : Hund Gesicht ablecken ?", "Zwangsr\u00e4umung droht", "Salz & Pfeffer : Kussmaul", "\u201e Masernimpfung wichtiger \u201c", "Gelbfieber , Tollwut : Impfstoffe Europa knapp", "Binnenmarkt   Deutschland l\u00e4sst Strompreis steigen", "Porridge ?", "Experten erwarten massive Flut Privatkonkursen", "Airport : \" Investition \"", "Steueroasen : EU steht Austrocknung Weg", "Fritz : Hotspot Neusiedlersee", "Gugging-Direktor : \" Kunst therapiert \"", "Josef Moser Schulreform : \" gel\u00f6st \"", "Hausmittel Erk\u00e4ltung", "Wintereinbruch : Unf\u00e4lle Verkehrsbehinderungen", "Abschied Ballett-Stars", "Rotes \" Urgestein \" Pension", "Fu\u00dfball-WM-Qualifikation : Starke Spanier , Abbruch Kroatien", "Fu\u00dfball-WM-Qualifikation : Teenager schie\u00dft \u00d6sterreich K.o .", "Standard-Werbeformen inklusive Preisinformation", "Tier-Leid Billig-Fleisch Ausland", "Diskonter Hofer startet Tierwohl-Projekt \" FairHOF \"", "Georg Friedrich : raunziger Wiener Berlin", "Promis Jens B\u00fcchners Hochzeit", "Handel : KURIER-Magazin \" Holz \"", "Jungunternehmer f\u00fchren Baubranche digitale Zeitalter", "Profit Kurzzeitmieten : Tausende Wohnungen verschwinden Markt", "Einzige Sozialp\u00e4dagogin \u201e fl\u00fcchtete \u201c Jugendhaft", "Bauprojekt Philipshaus : Rauer Wind Wienerberg", "verh\u00e4ngnisvolle Aff\u00e4re Arbeitsplatz", "Planking : Fitness\u00fcbung falsch", "Crawling : Fitnesstrend USA", "Geheimgang Monroe", "George Clooney : \" Amal sexuell bel\u00e4stigt \"", "Victoria 's Secret : \u00d6sterreichisches Model Nadine Leopold l\u00e4uft", "Polnische Medien : \" Kaczy\u0144ski , Totengr\u00e4ber Republik \"", "Paradise Papers : Bez\u00fcge \u00d6sterreichern", "\" Homosexuellenlobby \" : Scharfe Kritik Gudenus", "Diskussion Sozialversicherungs-Reform", "Nordwesten USA erkunden : San Francisco Seattle", "London : Britische Polizei ver\u00f6ffentlicht Fotos Grenfell Tower", "Explosives Nazi-Waffenlager", "Papageno schnappt Gulliver \u2019s : Drittgr\u00f6\u00dfte Reiseb\u00fcrokette entsteht", "Skifliegen : Stefan Kraft verbessert Weltrekord 253,5 m", "Formel 1 : Force India kommenden Saison komplett pink Start", "Schubert : \" Atmen\"-Hauptdarsteller Gespr\u00e4ch", "Markovics ' \" Atmen \" : Beeindruckend stilsicher", "Formbarometer Salzburger Leihgaben", "gr\u00fcn , sch\u00f6n Floridsdorf", "Deutschland - AfD Bundestag Probe stellt : \" aushalten \"", "EVP droht Orbans Partei Ausschluss", "Doppelstaatsb\u00fcrgerschaft flog : T\u00fcrke verlor P\u00e4sse", "UETD-Sprecher : \" t\u00fcrkischer Politiker Wien \"", "Austro-t\u00fcrkische Organisation ATIB stellt neu", "R\u00e4tsel Shukri Ghanem", "Magers\u00fcchtig : Angelina Jolie Extrem-Figur verbergen", "Mietzins erh\u00f6ht ?", "Pr\u00e4sidentin : \" Strafrichter , sch\u00f6ne Arbeit , harter Job \"", "Fisch-L\u00e4den Wien : Eishken Estate , Frischeparadies , Naschmarkt , Arge Biofisch , Takans Delikatessen", "\" heilige Quellen \" gesundheitsgef\u00e4hrdend", "15-J\u00e4hrige Lehre", "Schellings Experten : Steuergeld sinnlos vergeudet", "Expertin Schelling-Rede : \u201e Umfassendes Gesamtkonzept fehlt \u201c", "Urban Exploring : Wien , ( fast ) kennt", "Chinese zahlte 8.600 Euro Whisky gef\u00e4lschtem Etikett", "Gr\u00fcnen-Chefin Simone Peter : \" \u00d6sterreich Warnsignal \"", "Podcast : brutal Ludwig vs. Schieder ?", "Katalonien : Puigdemont versch\u00e4tzt", "\" Regionen Europas 300 Staaten \"", "Sodbrennen : Ern\u00e4hrung hilft nachweislich", "Neuer Stimulator stoppt Sodbrennen", "\u00e4ltere meisten bereuen", "\" Paddington 2 \" : Fensterputzer schwedischen Gardinen", "Hollendonner AutoScout24.at-Country-Managerin", "Libanesischer Premier Saad Hariri schiebt R\u00fccktritt", "NEOS schwebt \" Lobautunnel light \"", "Mann lag tot Wohnung Spanien", "Schuleinschreibung : \" sp\u00e4tes Julikind \"", "Rezept-Ideen altes Brot", "7 Orte , USA-Trip lohnt", "W\u00f6lfen zerfleischt ? R\u00e4tseln tote Britin Griechenland", "Strache fordert sofortige Sicherung Brenner-Grenze", "Flughafen Schwechat : Neuer Check-in NIKI Air Berlin", "Lohnsubvention Arbeitsmarkt wirkt", "Wechsel RFS : Freiheitliche Studenten Bundesobmann", "Paare trauen : Hochzeiten Scheidungen", "Online-Dating : ideale Zeitpuntk f\u00fcrs Treffen", "Ludwig Viktor : Bruder Kaisers liebte Frauenkleider", "Viva Austria Top 20 bekommt Schwarzjirg", "Promi-Aufgebot Gala Nacht Sports", "Laune angesagt", "T\u00f6dlicher Unfall Schutzweg", "Robert Pattinson verlobt", "Hedy Lamarr erh\u00e4lt Ehrengrab Stadt Wien", "Fu\u00dfball : Salzburg fixiert Aufstieg Europa League", "Lilian Klebow : \" , bekomme Baby \"", "H. C. Strache zeigt neuer Model-Freundin", "Humanic-Mutter verkauft Billigl\u00e4den", "perfekte Truthahn 11 Bildern", "N\u00e4chster Schock : Celine Dions Bruder tot", "Christiane H\u00f6rbiger : \" Mann furchtbar \"", "Ladenh\u00fcter Wunschkennzeichen", "Alpine-Krimi : Etappensieg Ex-Manager", "hr-lounge : Einblicke Personalchefs", "Nachlese : KURIER-HR-Lounge Puls 4", "Teenager Zeitung : Geschichtsb\u00fcchern stehen , entscheiden", "Gastkommentar Intergation : Tiefer bohren Symptome behandeln", "Rich Kids of Instagram : protzige Leben", "\u00d6sterreichischer Gr\u00fcnderpreis \" Ph\u00f6nix \" Kategorien vergeben", "N\u00d6 : Vorw\u00fcrfe Sex-Lehrer", "Kranke Postler l\u00f6sen Chaos", "Silberstein-Aff\u00e4re : Gusenbauer Druck , SP\u00d6 schweigt", "Food Trucks parken Wochenende Ottakringer Brauerei", "Food Trucks Wien", "Donald Trump schreibt Rede Angelobung , Internet lacht", "Trumps Rede Angelobung Volltext ( englisch )", "\u00d6BB : Neues Online-Ticketing T\u00fccken", "Lokale Wien pleite", "Trotz Anstieg Insolvenzen er\u00f6ffnen Restaurants", "Welttag Humanit\u00e4ren Hilfe : fehlt : Schulmaterial , Medikamente , Geld Nahrung", "Lobbying-Register : 417 Lobbyisten registriert", "eigentlich .. ? Industrie 4.0", "Buwog-Prozessbeginn Grasser & Co wackelt", "Pippa Middleton : \" privilegiert & arbeitsscheu \"", "Kroatien : Sprachlos Istrien", "Guide Michelin : Restaurant Kroatiens bekommt Stern", "\u00d6VP-Gro\u00dfspender Einkommenssteuer gezahlt", "Dieselgate : VW wusste Bescheid", "Zeman \" organisierte Invasion \"", "Neuer Roman : Typ Sterben ?", "Albertville 1992 : R\u00fcckblick", "Bilanz : Hofburg-Wahlk ( r ) ampf Rekorde", "Schulstart fehlen 150 Lehrer", "Top 5 : Bestes Fr\u00fchst\u00fcck Wien 1020", "Indien : Bus st\u00fcrzte hunderte Meter tief Schlucht", "  Herr 42.000 Mitarbeiter", "Dietmar Hoscher : \u2005 Faymann-Freund Blues-Man", "Darwins Huftiere : Elefant , eher Pferd", "Gesundheitscampus   Oberwart", "\" Campus \" 180 Betten Sch\u00fcler 2018", "Ronan Keating : Scheidung Verlobung", "Poller Kanzleramt : Kosten 615.000 Euro angestiegen", "Innnenministerium : Betonbl\u00f6cke Poller Gro\u00dfevents", "Waffenbesitz : Gef\u00e4hrliche L\u00fccke Psychotest", "\u00d6sterreich - Serbien Nachlesen", "Schichtbetrieb Krematorium", "Gesch\u00e4ft Tod : Trends letzten Weg", "Konkurrenz Amazon & Co : Wiener Handel startet Shoppingplattform", "Ex-Sprint-Star Sanya Richards-Ross : \" Wochen Olympia abgetrieben \"", "Wahlerfolg Demokraten New York , Virginia New Jersey", "Prozess Wien : ernannter \" Lovecoach \" Gericht", "Interview - Attila Dogudan : \" miteinander reden \"", "Dogudans : \" Vater kompromisslos \"", "Maul Kermit , Frosch ?", "Angelina Jolie : Jon Voight packt", "\" Dorftrottel \" : Billy Bob Thornton Ehe Angelina Jolie", "Erdogan Putin : Russland Druck Syrienl\u00f6sung", "\" Licht Welt \" : Dutertes Schmachtfetzen Trump", "Safthersteller Spitz : \" braucht jedes Neues \"", "Danica Roem : Virginia : Transgender zieht Abgeordnetenhaus", "Pizza Welt-Kulturerbe ?", "Streetstepper Bodyblog-Test : Stehen radeln", "R\u00fcckzahlung Kreditzinsen : RLB N\u00d6-Wien legt 13 Mio. Euro beiseite", "Dorf , Geschichte schrieb", "Wiens st\u00f6ranf\u00e4llige U-Bahnen", "Verschieben Sport ruhig aufs Wochenende", "Zahl Internetabh\u00e4ngigen steigt leiden Begleiterkrankungen depressiven St\u00f6rungen , Angsterkrankungen ADHS", "FP\u00d6 Vor-Wahltag Briefwahl", "\" Miami Vice \" Remake : Don Johnson", "Fu\u00dfball : Chelsea 4:0 Agdam Champions-League-Achtelfinale", "\" Pharmafeindliches Klima \" hemmt Innovationen", "Ben Marecek : knackige", "B\u00e4nderriss : WM- Saison-Aus Marlies Schild", "Spannende H\u00e4user erkunden", "Michaela Klein : Almdudler-Erbin Herz", "Partnervermittlung \" Dancing Stars \" : Liebesbilanz", "Blickfang Lets CEE Film Festival", "Lebensmittel Woche : Pumpkin Spice Latte Starbucks", "K\u00fcrbis-Rezept : funktioniert perfekte K\u00fcrbissuppe", "Millionenshow : Millionenfrage", "Mandatar postet Abseits", "\" Team K\u00e4rnten \" schlie\u00dft Martin Rutter", "Weightless : Marconi Union : Lied , Stress befreit", "\u00d6sterreicher gestresst", "H\u00e4upl warnt Schwarz-Blau : \" Kernianer \"", "Antisemitische Codes ORF-Debatte : Kritik Strache", "Ausmalen , abrei\u00dfen , anbauen : ?", "O'naturel : Welt Nackt-Restaurant reicher", "Fu\u00dfball : Wien Energie 2017 Rapid-Hauptsponsor", "Pippa Middleton zieht alten Lover James Matthews", "Millionen-Pleite namhaften Reifen-Gro\u00dfh\u00e4ndlers", "Anleitung : Selbstgemachtes Kaffee-Peeling Cellulite", "Andrea Fendrich meldet Privatkonkurs", "Beh\u00f6rde t\u00e4uscht , droht Gef\u00e4ngnis", "Lehrer : Pragmatisierung", "Opernball Gerstner : Preise Speisen Opernball 2016", "Esoterik Antwort", "Elon Musk : Wodurch all Beziehungen zerst\u00f6rt", "Alicia Keys schminken", "Justin Bieber & Selena Gomez vereint : voneinander loskommen", "Heiliger Nikolaus : Erzbischof Provinz , Schutzpatron Kinder", "Triest : Suche Reste Kriegsschiffes \" Wien \" Gange", "Mode-Ausstellung \" Vulg\u00e4r \" Belvedere : Attacken Graumausige", "THC Cannabidiol Schmerzen , Schlafst\u00f6rungen Appetitlosigkeit : Cannabis Allheilmittel Senioren ?", "Dubiose Flugzeugunf\u00e4lle : Minister sucht Verr\u00e4ter", "Aufschrei Stau-Chaos", "Gewinner KURIER Fotowettbewerbs", "Erdgas Grundstein Katar-Krise", "\u00d6sterreich 20 reichsten L\u00e4ndern weltweit", "Melania Trump : \" Ungl\u00fccklich First Lady \"", "Heer : VP-Kapit\u00e4n bl\u00e4st Generalangriff", "Pr\u00f6ll & Co. gedient \u2013 Heer mied", "Baby Tode gequ\u00e4lt : Mordanklage Vater", "Leder & Schuh relauncht Humanic-Online-Shop", "Coop Himmelb ( l ) au baute Kinozentrum S\u00fcdkorea", "Kleinod Schilf", "Tiroler Forstverein sieht Wolf Nutzen Wald", "Hype Ramen Udon : Wien schwimmt Nudelsuppe", "5 Restaurants", "Fr\u00fchjahr bl\u00fcht : Garten", "Justizanstalt Garsten : \" Zweifach Lebenslanger \" frei", "Dreharbeiten \" Schnell ermittelt \" sorgten Aufregung Wien", "Medienbeh\u00f6rde-Kandidaten stehen fest", "Mikl-Leitner Niessl Zentralisierungstendenzen", "FP\u00d6-Anfrage Asyl-Foto", "Slowenien : Syrischer Fl\u00fcchtling Regierung Fall bringen", "Kollektive Katerstimmung Feiertag", "Interview Johannes D\u00fcrr : \" Alleine untergegangen \"", "Neues Restaurant : Amadors Wirtshaus Grei\u00dflerei er\u00f6ffnet", "Anz\u00fcgliches Nachrufen strafbar", "\" Robin Hood \" : Abenteurer Gerechtigkeit", "Machospruch : Armin Assinger Genderseminar", "Mickey Rourke \" versch\u00f6nern \" lassen", "Zentralmatura 2017 : Themen Deutsch", "Ski-Verband lieben Familien", "Vanille , Safran , Charapita : Gew\u00fcrze teuer", "Havarie gr\u00f6\u00dften Luftfahrzeug Welt", "Salz & Pfeffer : Spelunke", "Museum Beethoven", "Schal : Tipps verfilzte Haare Nacken", "Prognose \u00d6sterreich : Mildes Weihnachtswetter", "Studie : gerne Augen schauen", "Motorradlenker prallte A23 Betonleinwand starb Spital", "Insolvenz : Haas Elektro GmbH pleite", "Wallner : \" Verstehe Aufregung Elisabeth K\u00f6stinger \"", "Straches Frau ' Freundin : Foto Spekulationen", "Display-Harmonie", "20 D\u00e9j\u00e0-vus St\u00fcck : Echte Doppelg\u00e4nger beliebter Filmcharaktere", "Katzen Pubert\u00e4t", "8 geniale Eier-Rezepte Obauers", "Personenschutz Familien Opfer", "\" Vorstadtweiber\"-Star Maria K\u00f6stlinger : \"   schwanger ,   Figur \"", "Pflege : St\u00f6ger plant neues Angebot", "Zeitzeugin Greta Klingsberg : Mut Lachen", "Worauf M\u00e4nner lockerer Krawatte hinweisen", "Unterschied", "Wort", "Ungeschminkte Wahrheiten : Amy Smart", "Spitzer profitiert Jukics Abwesenheit", "\u00d6sterreichisches System , adieu ?", "Gesundheitsbloggerin Zhang vergiftet Agave-Pflanze", "Inneministerin Johanna Mikl-Leitner : Hart , ziemlich herzlich", "\" Regierungen ? \"", "Israel   sieht Iran n\u00e4her", "heimischer Bauer verdient knapp 25.700 Euro", "Freddie Mercury : Star , Legende", "Kohlenhydrate : 5 Lebensmittel ,", "Chuck Norris-Witze 75 . Geburtstag", "Historiker Oliver Rathkol Interview Sehnsucht \" starken Mann \"", "Gisele B\u00fcndchen zeigt Luxus-Villa", "reichsten \u00d6sterreicher laut Forbes", "Fluglinie serviert Vegetarier Rohkost", "Sommeliers", "Eatkarus : Werbung : Edeka wirbt dickem Kind gesunde Ern\u00e4hrung", "\" glaub , nehm \u2019 Krautfleckerl \"", "Gulliver \u2019s Reisen : Verdacht Veruntreuung schweren Betrug", "Fl\u00fcchtlingsverteilung : EuGH l\u00e4sst Ungarn Slowakei abblitzen", "\" Karte setzen \"", "Vatertag schreibt Vater besondere Beziehung Tochter", "Cranberry-Saft verbessert Herzgesundheit", "Kickl \" Straches Hirn \"", "hr-lounge : Austausch Personalchefs", "Angelina Jolie : 500 Kalorien", "wahre Coke-zero-Geschichte", "Virales Video : Schwangerschaftstest mittels Zahnpasta ?", "Ronja R\u00f6nne : \" Sexismus . G\u00fcte . \"", "Kinderrezept Frischk\u00e4se", "Kardashians floppen gewaltig - TV Show Kylie Jenner", "Zahl illegalen Einwanderer USA bleibt laut Studie stabil", "Digitale Wegweiser Urlaubsgast", "Anker : Eckiger veganer Faschingskrapfen Verkauf", "Schwarze Schauspieler , Oscar gewannen", "Fitnessangebote speziell Frauen", "Herztod U-Bahn-Lift :   half", "Neuer Chef lenkt Josko bew\u00e4hrten Weg", "Mark Twain Wien : Haderlump . Bordellvater . Lausbub .", "Sebastian : \" Lieb\u00e4ugeln \u00d6xit \"", "Nachhilfe Generation YouTube", "Ex-OMV-Chef Gerhard Roiss Stromkonzern Verbund", "\" Staat Mehrheit Gasnetz halten \"", "Kletter-WM : \u00d6sterreichische Favoriten", "Anfang schwer ...", "Joe Biden Donald Trump anlegt", "Viggo Mortensen Interview Captain Fantastic : \" Wien vermutet \"", "Koalition : Regierung Weihnachten stehen", "Wiener Polizei fahndet sofort Facebook", "Stadt Zukunft voll Sensoren", "Pflichten Kleingarten", "Butters\u00e4ure-Attacke Tiersch\u00fctzer", "Sportclub-Platz : Entscheidende Hernals", "Anlageskandal Ertrag & Sicherheit : Schaden 220 Millionen \u2005 Euro betragen", "Frauen pirschen", "\u00d6SV-Todesopfer Stra\u00dfe", "Besch\u00e4ftigungsbonus : Milliarden Euro Firmen , Jobs Inl\u00e4nder schaffen", "\" Fratelli d'Italia \" offiziell Italiens Hymne", "Gr\u00fcne Nieder\u00f6sterreich : \u00c4ra Petrovic", "OLG Wien weist Anklage Wiener Arzt Thomas Unden", "Millionen-Pleite Videoverleihs", "Autoh\u00e4ndler Pappas ordnet F\u00fchrung neu", "Wohnungen Wien deutlich \u00fcberbewertet", "Budget-Hotels dr\u00e4ngen Wien", "Hasspostings Facebook & Co : Drohungen Netz", "\" 1984 \" Volkstheater : B\u00f6se , b\u00f6se Welt", "Anzeigenflut dubiosen Installateur", "Pflichten Eigent\u00fcmern", "Muslimische Rollenbilder - Integrationsprobleme Schulen : \" Frau lass \u2019 nix sagen \"", "leseZEICHEN : Maschine", "Promis Drogen-Gest\u00e4ndnisse", "Geschmack Gehirn : nimmt Hirn Essen ?", "F\u00fchrerschein", "Kern vs. : letzte Akt", "Westbahn-Tickets Trafik", "Georg Fraberger : Leben Arme Beine", "\" Tod , Wiener \"", "Rekord Monet : teuerste Heuhaufen Welt", "Millionenpleite Bodenleger-Firma", "Gerard Butler Urlaub Freundin Schluss", "Sonderkontrolle Licht   Akten-Aff\u00e4re bringen", "Gesch\u00e4digte MEL-Anleger erhalten 44 Millionen Euro", "Neuer Salzburger Weihbischof Hansj\u00f6rg Hofer : \" Andreas Laun wichtige Positionen vertreten \"", "Theater Drachengasse : Gerechtigkeit herumgeschubst eingewickelt", "Ski alpin : Nachwuchssorgen - Suche Hirschers", "Trump : Mulvaney Chef Verbraucherschutzbeh\u00f6rde", "Psychotherapeut R\u00fcdiger Dahlke Schicksal", "tausend Fl\u00fcchtlinge Mittelmeer Libyen gerettet", "wundersame Wandlung Charlene", "Multiple Sklerose : besonderer Ironman", "\u00d6sterreich-Besetzung New York Festivals-Jury", "IBM \u00d6sterreich : Oppitz , Neumann", "Krankenhaus Nord : Scharfe Rechnungshof-Kritik", "Sexueller Missbrauch : Ex-FP\u00d6-Gemeindepolitiker verurteilt", "Martin Suter : Schweizer Erfolgsgeheimnisse", "Kovacs : \" R\u00f6hre Nationalpark No-Go \"", "Millionen-Betrug Hypo Alpe Adria Udine", "Alkohol-Stopp t\u00fcrkischen Lokalen", "Liebhaber - Marguerite Duras", "Stra\u00dfenbahn-Zusammensto\u00df Wien-Alsergrund : Stra\u00dfenbahnfahrer \u00fcbersah Weiche Verletzte", "\" Rosenheim Cops \" drehen Staffel 17", "Interview Kuhn Hufnagl", "Trennung : Christian Rainer & Nadja Bernhard Begleitern", "Mormonen : 12-J\u00e4hrige outet , Mikro abgedreht", "Doris Golpashin : Ver\u00e4ndert Red Carpet", "Immobilien versteigert", "Hilde Dalik zeigt Haut \" Traumnovelle \"", "Neuer Bereich Media Services : ATV f\u00fchrt Kreativit\u00e4t Werbung", "M\u00e4nner : Sch\u00f6nheitsideal 100 ver\u00e4ndert", "Hurts : Spitals-L\u00e4rm morbiden Texten", "10 sch\u00f6nsten Frauen Welt : Kendall Jenner , Amber Heard", "\" Gazelle \" : n\u00e4chsten Kult-Sneakers Adidas ?", "Erwachsenenmalb\u00fccher : Mal gl\u00fccklich", "sieht Westbahn", "Craft Beer : Traum Brauerei", "Schalld\u00e4mpfer Jagd", "Top 15 Sehensw\u00fcrdigkeiten Welt", "Entdeckung Jungbrunnen : jungen Alten", "T\u00fcr spart GIS-Geb\u00fchr", "\u00d6sterreich : CO2-Emissionen 2015 Prozent gestiegen", "\u00d6BB : Nachtzuggesch\u00e4ft l\u00e4uft profitabel", "Justizanstalt Krems-Stein : Unsichere Zukunft ber\u00fchmt ber\u00fcchtigten \" Felsens \"", "All-In-Geh\u00e4lter : Rechner rentiert  ", "Wilderer : 50 Straftaten Anfang", "Pestizide : w\u00e4scht Obst ?", "Lebensfreude", "Wiener U-Bahn U5 t\u00fcrkis", "Wiener Umland : \" Preissteigerung enorm \"", "Wieso Darm untersch\u00e4tzte Superorgan", "6 Fakten Mietvertrag", "Koch Mangelberuf", "Strikte D\u00e4nen studieren Integrationspolitik Wien", "Pfarrer Sch\u00fcller fordert Kardinal Sch\u00f6nborn heraus", "Wien : Rocker-Pr\u00e4sident Drogendealer", "Flughafen holt   Frauenpower f\u00fcrs Bauen", "Gutachten enterbt : Gericht Haller freisprechen", "Gl\u00fcck Gewichtheber Steiner", "Treichl : Wutbanker Klassenfeind", "Glask\u00f6rpertr\u00fcbung : Behandlung notwendig", "Vatikan : Hostien Gluten enthalten", "\u201e Schulden 20 abbauen \u201c", "Waldegg - Alpakas f\u00fchlen Piestingtal pudelwohl", "Barbara Kaudelka : \" Leerl\u00e4ufe fast \"", "Grenz\u00fcbergang Kittsee : museumsreifen Jeep Verbrecherjagd unterwegs", "Festspielball : Rosen , Tango , ol\u00e9 !", "Fu\u00dfball : \u00d6FB-Kader Foda Janko , Ulmer", "Dauerstreit : Westbahn \u2013 \u00d6BB", "Widmung : Wohnung Praxis", "Wien -   Astana : Moskau 48 Stunden", "Fall Lucile : 40-j\u00e4hriger Rum\u00e4ne festgenommen", "Ariana Grande : singen", "Live-Ticker : Angelobung Bundespr\u00e4sidenten Alexander Van Bellen", "Leberkas-Pepi expandiert Wien", "Fr\u00fcchte Wunderland", "Saugbarben : \u00c4rzte warnen Fisch-Pedik\u00fcre Hautschuppen", "Wege Pflege-Dschungel", "\" Forbes \" : Mateschitz bleibt reichster \u00d6sterreicher , Bill Gates reichster Mann Welt", "Aktion 20.000 : Arbeiterkammer Gewerkschaft Fortf\u00fchrung", "Wolfgang Ambros : \"   Selbstmord gedacht \"", "Kr\u00fcger : \" Haider FP\u00d6 starken Rechtsruck \"", "Anna Netrebko & Eyvazov : \" Baby \"", "Angeles : Stadt unbegrenzten M\u00f6glichkeiten", "Skispringen : Neues alter Bekannter", "Pflegende Tochter k\u00e4mpft   Existenz", "fantasievollsten Schulen Welt", "Johnny Depp : H\u00e4user verkaufen ?", "Weiterhin R\u00e4tselraten Hariris Schicksal", "Nova Rock , 2 : Feuerzeugen", "Enrique Iglesias : Freundin Anna Kournikova kennt Vater Julio", "Deutschland : Kurswechsel Richtung Koalition ?", "Kurier TV-News : \u00d6VP FP\u00d6 versch\u00e4rfen Asylthema", "weibliche Seite   Terrors", "angekommen : Wien dreht Christine Reiler", "Kind : Hermann Maier feiert wild", "Moxy-Hotel Wien Schwechat Start", "Morgan Mikenas : Wieso aufgeh\u00f6rt , rasieren", "Witwe trifft Mann Gesicht verstorbenen Mannes", "Doppelmord : Gest\u00e4ndnis", "\u00d6AMTC : sieht Zentrale Wien", "Helikopter-Weltcup : Thomas Morgenstern Luft", "Fu\u00dfball : Galatasaray schloss Ex-Profis Hakan S\u00fck\u00fcr Arif Erdem Verbindung G\u00fclen-Bewegung", "Ungew\u00f6hnlich :   Jennifer Love Hewitts ' Sohn", "KURIER-Serie : Genetiker Hengstschl\u00e4ger diskutiert Thesen \" Homo Deus \"", "Ansto\u00df :", "Donald Trumps Gesundheitspl\u00e4ne : Frauen protestieren Netz", "Orban erkl\u00e4rt Ost-Mitteleuropa \" migrantenfreien Zone \"", "Gesch\u00fctzte Greifv\u00f6gel Nieder\u00f6sterreich vergiftet", "sch\u00f6nsten Frauen wohnen", "Spezialcomputer Wachkoma-Patienten", "Liste Pilz : \" Streit \"  ", "Verm\u00f6gen Schlagerbands : Amigos , Calimeros , Fantasy", "Gerangel   Gemeindebau", "Waffenpassbesitzer", "\" Detroit \" : Albtraum Algiers Motel", "Weinviertel Prag : Zugauskunft schlug Routen Wien", "\u00d6sterreichs Banken aufr\u00e4umen", "Vergewaltiger sieht Justizopfer", "\" Jugend \" : , Stereotyp", "Mietvertrag verl\u00e4ngern ?", "Rote Schlammschlacht", "Krapfen Blindtest", "Magna Europa Vorstand Flasch trennen", "Lopez & Beckham : Promis Freunde", "Notenbank : Kandidaten , Top-Jobs", "Gr\u00fcner Tee : Grazer Forscher enttarnen Wirkung  ", "Nationalratspr\u00e4sidentin Prammer spricht Krebs-Erkrankung", "Copa : Anzeige Konkursverschleppung", "Pubert\u00e4t - wichtigsten Fakten Tipps", "Donald Trump : schiebt Melania B\u00fchne", "Hilferuf t\u00fcrkischen Mitarbeitern Zara-Etiketten gefunden", "Wanda Interview : \" Wrack \"", "Millionen-Banker Konkursfall", "Deutsch-libanesischer Regisseur Imad Karim : \" befinden mitten islamischen Inquisitionszeit \"", "Megan Fox Ashton Kutcher : Sch\u00f6nheitsfehler Stars", "Kopflaus-Alarm : Tipps Kratzen", "Malta-Connection : Wetten , Bier Luxusjachten", "Mandeln optimale Snack", "Kult-Gasthaus Look", "Beisl   Wiener", "Drachenfrucht Pitahaya : Unbekannte Vitaminbombe", "Seilspringen : Ideal Abnehmen Auspowern", "Zielfahnder : \" T\u00e4ter voraus \"", "Salzburg \u00fcberrollt Sturm Weg Spitze", "Verd\u00e4chtiger Koffer : Klinikum St. P\u00f6lten abgeriegelt", "Diane Kruger : Aff\u00e4re Schauspieler Norman Reedus ?", "Kosten : Deutschen bleibt Lohn", "Stores : Wien : EDITED Mariahilfer Stra\u00dfe er\u00f6ffnet", "\u00d6VP FP\u00d6 begannen Verhandlungsrunde", "erkennen Leseschw\u00e4chen Kind", "Vater-Tochter-Beziehungen : K\u00f6nig Papa   Prinzessin", "Conchita wirbt lokales Shopping Wien", "Mittelmeer-Route : 1720 Tote Jahresbeginn", "Plasser : \" EU besitzt Schl\u00fcssel Populismus \"", "Restaurants : Fr\u00fchst\u00fcck : Vienna to go : kleinste Fr\u00fchst\u00fccks-Lokal Wiens er\u00f6ffnet", "Forscher finden heraus , Gl\u00fcck kaufen", "10 Tipps Soforthilfe Halsweh", "Oberstufe Schulalltag bedeutet", "Trauben Ausland : steirische Winzer \" Weltweinen \" Frost trotzen", "\u00d6BB starten Herbst \" Rail and Drive \"", "20 harte Fakten Penis", "Gerangel   Botschafterposten", "Tattoos : schmerzhaftesten Stellen", "Salzburg : Saalfelden sucht Eremiten Einsiedelei", "Stadtviertel Wien", "Salz & Pfeffer : Grace", "Gesch\u00e4fte Nostalgie", "Watergate-Aff\u00e4re : Richard Nixon Fall brachte", "Mongol-Rally : gr\u00f6\u00dfte ( irrste ) Abenteuer", "Nationalratswahl 2017 : Steckbrief Heinz-Christian Strache", "vererben : erbt Haus Hof ?", "Uber-\u00d6sterreich-Chef Andreas Weinberger Interview : \" umgehen Wien Gesetze \"", "EU-Urteil : Fettleibigkeit Behinderung Beruf gelten", "Meidling Pharma-Mekka", "Markenwert : Top 10 \u00d6sterreich", "Energie 2030 : Strom erzeugen", "Salafisten-Lekt\u00fcre Justizanstalt", "Mitgefangen , mitgehangen", "Bodyblog : # rufdennotarzt Gymclub", "\" Armut unsichtbar , dennoch Realit\u00e4t \"", "\" Grandios \" : Neuer Store Plus Size-Mode Wien", "3000 NATO-Transporte \u00d6sterreich", "Schengener Abkommen : 20 Grenzkontrollen \u00d6sterreich", "247 \u00d6BB-Garnituren bekommen Upgrade", "Andritz-Chef Wolfgang Leitner kehrt Staatsholding", "Tricks : statisch aufgeladene Kleidung", "Bild Prinz Gabriel : Carl Philip & Sofias Baby", "\" Stammtisch , Freunden , f\u00e4llt Anspannung \"", "Matthias Mayer : \" Olympiasieg hilft \"", "Marlies Schild Benjamin Raich : Kirchliche Trauung", "15 wichtigsten Food-Trends 2017", "Bildmanipulation : \" Krone \" Einzelfall", "Alfons Haider : \" Warmer verkauft Butter \"", "2030 : Zukunft essen", "\" Grasser-Haider-Skizze \" : Bristol begann", "Heidi Klum : lenkt Liebeskummer", "\u00d6BB Catering : Henry f\u00e4hrt l\u00e4nger Zug geplant", "WEGA-Chef : \" Polizisten chancenlos \"", "Samthandschuhe Sexualstraft\u00e4ter", "Krages : 22 Bewerber Spit\u00e4ler-Chefposten", "Bau-Razzia : gro\u00dfem Stil Scheinrechnungen erstellt", "Mindestsicherung Wien teurer : Massive Kritik", "Millionen-Pleite Transportunternehmens", "\" Enormer Druck \" Schiedsrichter", "Pornografie 3-D Kunstfilm", "Gr\u00e4tzel-Kaiser : Gasse Wohnzimmer", "Ehefrau erstochen : 20 Haft kolumbianischen Rockmusiker", "Panda Co. locken Massen Sch\u00f6nbrunn", "Parties , Stars & Schnee : Kitzb\u00fchel-Highlights", "Explosionsgefahr - Wiener Neustadt : Brisanter Waffenlager-Fund", "einflussreichsten K\u00fcnstler 2012", "U4-Station Friedensbr\u00fccke saniert : Teilsperre", "geheimen U-Bahn-Tunnel Wiens", "\" Pokerspieler \" Beruf", "Fl\u00fcchtlingsverteilung EU : Ern\u00fcchternde Bilanz", "Facebook-Gemeinschaft   stellt Wahl mischt Stadtpolitik", "Unn\u00fctzes Wissen : Skurrile Fakten Medizin", "Zeichen ! Welthandel lebt", "Liesing - Prostituierte tanzen Stra\u00dfe : Anrainer verteufeln Strich", "Spalte \u00fcberlebt", "\u00d6BB-G\u00fcterverkehr Spuren Seidenstra\u00dfe", "Artenvielfalt : Tiere \u00d6koingenieure , Aussterben droht Chaos Lebensraum", "\" Salzburg totes Pflaster \"", "Kampf ums Nachbarhaus beendet", "Expertin Tipps : gef\u00e4lschte Designerware erkennt", "einflussreich Prinz George : Mode-Vorbild", "Niki Lauda : Neidgenossenschaft", "N\u00e4chstes Auftragsmatch : Wiener Linien schreiben U-Bahn-Z\u00fcge", "Tschechien : Bierbrauer Wellnesshotells S\u00fcdb\u00f6hmen", "Bachmann-Preis : verzopfteste Castingformate", "Zadar : Meeresorgel Sonnendenkmal", "Facebook-Hype : Spruch", "\u00d6sterreichische Weihnachtsbr\u00e4uche-   Weihnachten lustig", "Skyr : isl\u00e4ndische Joghurt , eigentlich keines", "Anwalt :   \" Frank Stronach f\u00fchlt geprellt \"", "Salz & Pfeffer : Toni 's Kulinarium 7", "Moderne Sklavinnen Libanon", "Ost-West-Gef\u00e4lle Deutschland : Merkel ortet strukturelle Probleme", "Wahl 2017 : W\u00e4hlerstromanalyse", "Sarah Wiener kritisiert Backshops : \" Hauptsache billig \"", "Monika Gruber : \" Privat Dauerpausenclown \"", "\u00dcberfall-Serie Wien gekl\u00e4rt , Opfer gesucht", "Internet-Plattform bietet WG-Zimmmer Fl\u00fcchtlinge", "schr\u00e4gsten Studien 2016", "Versuchte Vergewaltigung Donaupark", "Politik verbannt Gras Shops", "Beamten-Lohnrunde startet mitten Wahlkampf-Finale", "Angelina Jolie Kids : Eigenartiger Auftritt Billig-Store Target", "Haselsteiner Z\u00f6chling kaufen riesigen Logistikpark", "Arbeitslosigkeit importiert", "Dandy-Look : Frauen m\u00e4nnlich", "Wien Fl\u00fcchtlingskinder Schulen integrieren", "Unterkunft Obdachlose", "Liebe hinf\u00e4llt", "Erdem x H&M : ergattern Lieblingsteile", "Erdo\u011fans Spitzel \u00d6sterreich Gesichter", "Failed States : Staaten scheitern", "Mobbing Schule : \u00d6sterreich OECD-Vergleich Schlusslicht", "Hypo holt Zagorec-Millionen", "Verhandlung S1-Spange Seestadt Aspern beginnt", "KURIER-Schwerpunkt # GegenHassimNetz - Demagogen Internet Paroli bieten", "15 Animes gesehen", "ZOOM-Kindermuseum : Eintauchen Welt gefl\u00fcchteter Kinder", "Sch\u00fcler beschwert   grausige Unterkunft", "Manfred Ainedter Rechthaberer : Topanwalt Plus 4", "Studie \u00d6sterreich : Woran Psyche Kindern Jugendlichen leidet", "Extremsport : \" Jedes Land Spinner \"", "41 Seniorenheim", "Fliegen Schwangerschaft : Empfehlungen", "Zwist Grundst\u00fccksgrenzen", "Stillgelegt : 100 verlassene Orte , dokumentiert Thomas Kemnitz , Robert Conrad Michael T\u00e4ger", "Tiroler Tageszeitung besetzt Funktionen", "Vegan : eigentlich Tofu ?", "Wirbel Politbesetzung Bildungsinstitut bifie", "Vergleich : \u00d6sterreich sicher Terror ?", "Uber-Fahrer 3,75 Euro Stundenlohn", "Wellness : Luxus-Day Spas Wien", "Nadja Bernhard Interview Welt", "Skandalbau Krankenhaus Nord : Licht Tunnels", "Kopfschmerz Einbildung", "Schwuler B\u00fcrgermeister traut \u2013 bekommt kirchlichen Segen", "Verkehrszeichen-Quiz : Kennen ?", "\" scharf   , wirkt flach \"", "Fischz\u00fcchter Alexander Quester bleibt Umweltschaden sitzen", "K\u00fcnstliche H\u00fcfte AKH : Patient erz\u00e4hlt OP Erfahrungen", "Geldw\u00e4sche Anf\u00e4nger : Methoden Kriminellen", "Vorwurf Steuerhinterziehung : Trenkwalder junior entlastet", "Kornspitz-Erfinder Peter Augendopler : Sauer Teig", "Pfusch Bau : Baum\u00e4ngeln ?", "Drama Wiener Oper", "Junkie & Supermodel Carr\u00e9 Otis ?", "Gagen beliebtesten TV-Stars", "Offene Abgabenforderungen : Republik schickt Anwalt Pleite", "VIDEO : Sturm vereitelt Flugzeuglandungen Salzburg", "Antrag Konkurs NIKI eingebracht", "TV-Moderatorin Schneider : \" geheult \"", "Wiener Staatsoper : Kinderopern-\u00c4ra Walfischgasse", "Formel 1 : Lauda Wolff verl\u00e4ngern 2020", "Stuart Freeman Brexit : \" Zukunft Jugend weggew\u00e4hlt \"", "Erwin Wurm : \" Migration Welt \"", "Ursula Voss : hielt", "EBEL : KAC \u00fcbernimmt Platz", "US-Elektroautobauer Tesla Service Center Showroom Wien", "Neuer Palmers-Chef : \" Tradition Altlast \"", "Air Berlin : Easyjet sieht h\u00f6here Ticketpreise", "Bitcoins sofort Post-Filialen erh\u00e4ltlich", "Optimismus Rapid : \" spielen Sieg \"", "Asylbescheid : Umzug \u00d6sterreicherin Afghanistan \" zumutbar \"", "EU-Staaten sprechen erstmals Beziehungen UK", "Herrschaft Assad-Familie Syrien", "amtliche Best\u00e4tigung", "Neos-Studenten protestieren EU-Zugangsbeschr\u00e4nkungen", "Ex-\u00d6VPler betrieb \" Privatinitiative \" Sudelseite Kanzler", "alten Regierung k\u00f6nnten \u2013", "Nationalparks : Drohnen-Angriff Naturjuwel", "Wassermann \u00fcbernimmt F\u00fchrung K\u00e4rntner Medienhaus", "Raubkunst : Eigent\u00fcmer zieht Bild Auktion", "\" Beste Rede Zeiten \" : Trump erfindet Pfadfinder-Lob", "Eishockey-Meister Vienna Capitals st\u00e4rker", "Polen : Regierungschefin Szydlo verurteilt Extremismus", "10 Tipps entspannte Weihnachten", "Grazer Kindergarten schlie\u00dft \" Psychoterror \" : Justiz machtlos", "Missbrauchs-Debatte : M\u00e4nner gestehen # IHave sexuelle \u00dcbergriffe", "Herz-OP : Jugendliche checkten Live-\u00dcbertragung", "Wilde Westen Italien", "wichtigsten Fragen Grundst\u00fcckskauf", "Verschw\u00f6rung ? dran Theorien ?", "Ski-Trag\u00f6die Bill Johnson : letzte Bitte Siegers", "Reichtum \u00d6lsand gebaut", "Klug entmachtet Gener\u00e4le", "Mondlandung 2.0 2021 geplant", "klingt Integration", "Schumacher-Ferrari New York 7,5 Millionen Dollar versteigert", "Millionen-Pleite Bauunternehmens", "Wien : Schwan prallte Fensterscheibe U-Bahn-Station", "Beschlossen : Haselsteiner   neuer Bezirkshauptmann", "Park & Ride : Pendler drau\u00dfen bleiben", "Macaulay Culkins Vater : \" Sohn \"", "Historien-Boom : Kost\u00fcmfilme j\u00fcngeren Datums", "Pressekonferenz Wei\u00dfen Haus : Reporter sagen , wof\u00fcr dankbar", "V\u00f6gel", "200 alt", "Dirk Stermann : Freundin Schluss", "Tian Paul Ivic : \u00d6sterreichs vegetarischer Drei-Haubenkoch", "Kaufmann : Leben", "Michelle Obama holt coolstes Kleid Schrank", "Albanien befreite B\u00e4ren Kosovo erstmals vereint", "Bodylotions Test", "\" lebende Bankomat-Kassen produziert \"", "Dagmar Koller privat : unver\u00f6ffentlichte Bilder", "Gr\u00fcner Chorherr legt Namen Spender", "Lisa Marie Presleys harter Kampf Sucht", "Sven Hannawald : Foto-Diss Ex Alena Gerber artet", "Erfolgskonzept Veganismus", "Schauspieler Morteza Tavakoli : \" amerikanische Alptraum \"", "Pkw-Maut : Ausl\u00e4nder zahlen Autobahnen", "Schwarzes Gold : teuersten Schallplatten Welt", "Mexiko : 15-J\u00e4hriger entdeckt Maya-Stadt", "Drogensucht : \" Lass , fallen \"", "Wien erh\u00f6ht Geb\u00fchren Wasser , M\u00fcll Parken", "\" John West\"-Produzent \u00e4ndert Fang-Methoden", "Charlie Sheen : krank Kinder ?", "Bundesheer : Scharfe Kritik Generalstabschef Commenda", "Bio-Apfelessig nat\u00fcrliches   Antibiotikum k\u00fchlere", "Coke Zero abgeschafft", "Prostitution Lugner City : Richard Lugner \" verdeckter Ermittler \" Einsatz", "Puff Lugner-City ?", "Fl\u00fcchtlinge : Heimreise Krieg", "Ski Alpin : Kanadierin Larisa Yurkiw h\u00f6rt 28", "ORF2-Magazin \" Leben \"", "Neues Restaurant Merak Wien - Karriere : Kicker verkauft \u0106evap\u010di\u0107i", "Br\u00f6tchen bestellen : Brotkost \u2013 neuer Lieferservice Wien", "Fr\u00fchst\u00fcck Elisabeth Kulman", "Neues Buch Einblicke Leben Essst\u00f6rung", "\" Il Trovatore \" : Luna originaler Bariton", "Tote \u2013 Untersuchungsbericht", "FP\u00d6 : \" Frauenh\u00e4user zerst\u00f6ren Ehen \"", "Letzte Raab-Show 19 . Dezember", "Brain drain : Arbeit : Osteuropa wandert", "Anteil Raucher \u00d6sterreich 2012 stark zur\u00fcckgegangen", "K\u00f6nigin Letizias straffes Sportprogramm", "FIBO-Trend EMS : Muskeln Strom - gesund ?", "Mindestens 15 Tote Autobombenanschlag Bagdad", "Jack Unterwegers Vertraute : \" M\u00f6rder geliebt \"", "Vatikan : Papst Benedikt XVI . zur\u00fccktreten", "Marihuana pers\u00f6nlichen Gebrauch Ohio", "Jack Nicholson : Kokain Prinzessin Margaret", "Entschuldigung Causa \" Bakary J \"", "Johnson : Wiederaufbau Syrien Assad", "Golfclub Fontana : K\u00e4ufer dringend gesucht", "Zeitungs-Workshop 2/der WMS Leipzigerplatz/MSK", "Bauer k\u00fcnftig F\u00f6rderung", "SP\u00d6-Mandatarin Yilmaz klagt UETD-Sprecher Rufsch\u00e4digung", "\" Au\u00dferhalb EU gedeihen \"", "Opernball 2017 : Kleid tr\u00e4gt Mirjam Weichselbraun", "Lebensmittel , abends essen", "Unentschuldigt", "Transplantationsbericht : Organspender \u00d6sterreich", "B\u00e4ckerei Str\u00f6ck \u00fcbernimmt Catering Westbahn", "Ausgew\u00e4hlte Trump-Zitate Klimawandel", "Volksbefragung : 10 st\u00e4rksten Argumente Wehrpflicht", "Promis Krebsdiagnose umgehen", "Trainer Toni Polster verliert Wiener Viktoria 0:24", "Altbau vs. Neubau : Frage Geschmacks", "Oskar Werner : Gr\u00f6\u00dfte letzten Winkerl", "Vergabe-Streit Wiener Stra\u00dfenbahnen", "Madagaskar : Opferzahl steigt Pest-Ausbruch", "\" Zeiten abnehmenden Lichts \" : Eingelegte Gurken Geburtstag", "Forscher \u00fcberzeugt : \" Alzheimer 2025 heilbar \"", "Geburt : Sohn Jason Statham Rosie Huntington-Whiteley", "UberGiving : Uber & Fadi Merza sammeln Obdachlose", "Rekord-Achterbahn \" Flying Aces \" Abu Dhabi er\u00f6ffnet", "ZARA-Report : Rassismus \u00d6sterreich erreicht neues Level", "Libro-Pleite 14 abgeschlossen", "B\u00fccher lesen !", "Joesie Prokopetz : Doppelhochzeit Wolfgang Ambros ?", "Wanderer verspeiste giftigen Eisenhut", "Ungarn \" emp\u00f6rt \" EU-Abgeordnete", "Forscher entwickeln Brot Farbstoff Anthocyan schwarzem Reis Diabetiker", "Toter S\u00e4ugling : Vater gestand , Baby gesch\u00fcttelt", "Unverpackt : Grei\u00dflerei T\u00fcte", "Sonderbare Tiere : Sternmull", "Einbrecher r\u00e4umten   Bank-Schlie\u00dff\u00e4cher", "Plimpton 322 : 3700 alte Tontafel legt nahe , Babylonier Trigonometrie erfunden", "Rapid plant 30-Millionen-Budget", "Starker Trend Single-Haushalt \u00d6sterreich", "Glattauer : \" Kinder schmoren Saft \"", "Umweltbewusst sozial ? \u00d6sterreichs Firmen s\u00e4umig", "Fettweg-Methoden Check", "Verlorene Railjet-T\u00fcr : Geldstrafen \u00d6BB-Manager", "Weltkonzern : \u00d6sterreicher Peter Oswald neuer Mondi-Chef", "J\u00e4ger klagen : Wolf scheu", "Strache Firma Rumpold betrieb", "Drachenblut - Christoph Hein", "Asylwerber Monat spurlos verschwunden", "Neujahrskonzert 2017 : Silberstaub , \" Donauwalzer \" neues Outfit", "Paris Hilton trennt Austro-Million\u00e4r Thomas", "Catoil drohen Russland bohrende Probleme", "Dancing Stars : Finalisten stehen fest", "Fitness-Model zeigt Wahrheit \" perfekten \" Fotos", "Staudamm \u00c4thiopien : Kenia f\u00fcrchtet Wasser", "EU China : Fast Freunde", "Liebe Maren Gilzer Unternehmer Harry Kuhlmann", "Hightech Wildschwein-Jagd", "Forschung : Training Geruchssinn", "Welser Logistiker TGW-Gruppe sucht 330 Mitarbeiter", "Ehepaar Aspern get\u00f6tet : Mordprozess", "600 G\u00e4ste   Mitterlehners   60er-Fest : \" Zahl pickt halt \"", "K\u00f6chin Haya Molcho Interview", "Norwegen \u2013 gr\u00f6\u00dfte Walfangnation Welt", "Koch r\u00fchrt Stiftungen  ", "Messerscharfes Handwerk : 23-J\u00e4hriger j\u00fcngste Schmied \u00d6sterreichs", "# PutinShirtlessChallenge : Russen messen Putin", "Praterstern bleibt Streitthema", "Arbeiterkammer Parkplatz-Abzocke Gericht bringen", "R\u00fcckkehr Grei\u00dfler", "Steuerberater Vergangenheit", "Almrausch - sch\u00f6nsten H\u00fctten \u00d6sterreichs", "Bad Gastein : Akuthilfe verfallenen Ortskern", "Gery Seidl tr\u00e4gt Herz Zunge", "Daniela Fally : \" gl\u00fccklich \"", "Wild-Lokale", "Johann Lafer : Waldpilzrisotto Sekt", "\" Sexy \"", "12 Lebensmittel , K\u00fchlschrank geh\u00f6ren", "13-J\u00e4hriger geriet Wien Schusslinie : Prozess wiederholt", "Waltz : \" Wiener besessen Tod \"", "Kern verh\u00e4ngt \" \u00d6sterreich \" Inserate-Boykott", "Per Mausklick Arzttermin : Internet-Plattform", "Gl\u00fccksspiel : Automaten-Mafia lukriert 350 Millionen Euro", "Aufnahmetests AHS Schulstreit H\u00fcrde", "B\u00fcrger wehren Schrottplatz", "M\u00fcllkrise : Rom Abfall \u00d6sterreich entsorgen lassen", "Familienfreundlichkeit : Kinderwunsch \u2013 Wirklichkeit", "Neandertaler-Erbe beeinflusst Hautton , Schlaf- Rauchgewohnheiten", "Besch\u00e4ftigungsbonus : EU-Okay fehlt", "Schwedenr\u00e4tsel", "Senioren & Online Dating : \" Silver Singles \" erobern Netz", "Milborn l\u00e4dt Baumgartner : \" sicher Eier \"", "Kirisits \u00fcbernimmt O\u00d6-Nachrichten-Anzeigenleitung", "\u00d6sterreicher online einkaufen", "beziehen Mindestsicherung", "\" finde lustig , Sozialstaat abh\u00e4ngig \"", "Pharmakonzern MSD Animal Health siedelt Krems", "70 Marshall-Plan : \" Spezialfall \" \u00d6sterreich \u2005 Milliardengeschenk USA", "Altbundespr\u00e4sident Heinz Fischer Ehrenb\u00fcrger Wiens ernannt", "Lebensmittel : Bio Suppenw\u00fcrze \u201e Emilie \u201c", "Salat-Rezept : Japanischer Nudelsalat Mittagessen", "Rabenhof-Theater : Rumpelstilzchen - Mobbingopfer ?", "Irland pocht Kl\u00e4rung Grenzfrage Brexit-Verhandlungen", "Typischer Tagesablauf : angepasst leben Millennials", "Siemens schlie\u00dft Werke streicht 7.000 Stellen", "IMMO Inside : Preis Klinikum Klagenfurt", "Meinl-Tochter schluckt Niemetz", "Fehlalarm Masern", "Klaus Heidegger : American Dream Albtr\u00e4ume", "OECD-Studie : \u00dcberalterung Gesellschaft f\u00fchrt \" zunehmendem Ausgabendruck \"", "TU Wien-Studie : Airbnb entzieht Wiener Wohnungsmarkt 2.000 Wohnungen", "Aufgetaucht : alten Nacktbilder Jamie Dornan", "Barisic : \u201e Kovacec   Drittliga-Spieler \u201c", "Nieder\u00f6sterreich gew\u00e4hlt : Ergebnisse Gemeinderatswahl 2015", "Beteiligung : Neuer Stadtteil neuem Zentrum Entstehen", "Friseurbesuch : Frauen Haare schneiden", "warnt Rede UNO Atomkrieg", "finale Showdown : Marquez Dovizioso", "Explosion Einfamilienhaus Hollabrunn", "Section Control Fall Juristen", "Kriminalstatistik \u00d6sterreich", "Betriebskosten-Abrechnung", "meistgehassten Promis", "Fortune-Liste : m\u00e4chtigsten Managerinnen Welt", "Nordkoreas Au\u00dfenminister : Raketenangriff USA \" unvermeidlich \"", "Fritz Karl : Kinder 6", "Fernbeziehung eifers\u00fcchtiger", "Wolfgang Kulterer : Arm Kirchenmaus ...", "Izetbegovic ' Kosovo-Aussagen erregen Unmut Serbien", "Rekord : 12.760 Arzt", "Steuersparen M\u00f6bel-Chef : Schelling wortkarg", "Freigang Gesicht geschossen", "Brangelina-Scheidung : Neuigkeiten Brad Pitt", "2 Minuten 2 Millionen : 300.000 Euro Protein-Soda Zeus", "Feminismus braucht Kunst ?", "Christiane Spiel Interview :   Lehrer guten Lehrern", "Vergewaltigung Rimini : Polen fordert Auslieferung", "Cannabis Wert 500.000 Euro Wien-Meidling sichergestellt", "\" Gilmore Girls \" : Rorys Baby weitergehen", "Kultur , Unterhaltung", "Kim Kardashians \" verr\u00fcckte Di\u00e4t \" funktioniert", "Appell Schwarz-Blau : \u00d6sterreich braucht Bahn", "St. P\u00f6lten : Verwirrung digitale Vignette", "Stress Justin Bieber", "Amber Heard : Depp schnitt Drogenwahn Fingerkuppe", "Universit\u00e4tskonferenz \" Studieren \u00d6sterreichisch \"", "Gelassenheit Seoul : \" Korea sicherer Deutschland \"", "Ivona Dadic : Arbeit , Schokolade", "Shermine Shahrivar : l\u00e4uft Fiat Erbe Lapo Elkann ?", "Region Wilder Kaiser : \" Bergdoktor \" gedreht", "Buben missbraucht : Haft Wiener", "Neuer Dengue-Impfstoff :   zugelassen", "T\u00f6dliche Heimfahrt \u00d6sterreich", "\" lieben Raymond\"-Stars", "Leben Flucht beginnt langsam", "Marianna Goulandri & Philippos Lemos : K\u00f6nigliche G\u00e4ste High Society-Hochzeit London", "beliebtesten Moderatorinnen Deutschlands", "Stilles Mineralwasser Leitungswasser", "Kaufmann : Schwarzen Brett", "Top 5 : Fr\u00fchst\u00fccken Wien 1040", "Apnoetauchen : 22,5 Minuten Sauerstoff Wasser", "Kopftuch-Emoji : Wiener Sch\u00fclerin Time Magazine geehrt", "Scheinehen : Tests , Verurteilungen", "Hadsch : Pilgerfahrt Mekka wissen", "Bauernhof bietet Schlachtkurse", "Tatort-Ermittler Gemeindebau", "\" Tschick \" : Freiheit blauer Lada", "Kinder ver\u00e4ndern Karriere", "Blog Heimskandal - Opfer Amts", "Mutma\u00dflicher Terrorist Wien Mehrfachm\u00f6rder angeklagt", "Grazer Installateur Dipl . Ing . Wagner pleite", "Einigung Handels-KV Gehaltsplus 2,35 2,6 Prozent Bildungspaket", "Risikobarometer : \u00d6sterreicher f\u00fcrchten \" Terror \" \" Asylanten \"", "Posse Ehrenb\u00fcrgerschaft", "Kinderwunsch : Vitamin D hilft , schwanger", "Austro-Model liebt Mariah Careys Manager", "Familiendrama N\u00d6 : Fieberhafte Suche Motiv", "Stermann : \" hauptberuflich Deutscher \"", "\u00d6BB : Kampf Gro\u00dfauftrag spitzt", "Sex Doctors : Burnout , Depression Libido zusammenh\u00e4ngen", "Jean Ziegler : \u201e Albanien Alpen \u201c", "Promis historischen Doppelg\u00e4nger", "Nadal Sieg del Potro US-Open-Finale", "Waldviertler B\u00e4cker Faible Klassikmusik", "Herd Ernst Grissemann", "NR-Wahl : Roland D\u00fcringer entlud Mist Parlament", "Afrika : Fu\u00dfball-Trainer wirft Spielern hohen Porno-Konsum", "Wien er\u00f6ffnete vegane Sozialmarkt", "Dachsteink\u00f6nig : fast perfektes Kinderhotel", "Experten Sinn Unsinn Noten : bringen ?", "Weltmuseum menschliche Relikte", "Neues Restaurant l'autentico giardino serviert neapolitanische Pizza Garten", "My Indigo Soul Kitchen : Thomas Sykora er\u00f6ffnet Lokal Wien", "Charlie Sheen k\u00e4mpft Demenz", "Opernball Trash-Stars 2016", "Experte kritisiert teure \" Pensionsparallelwelten \"", "Shedlin Fonds : \u00d6sterreicher bangen 35 Millionen Euro", "Anlegerin punktet Verm\u00f6gensberater", "Sepp Schellhorn Interview : \" Inaktivit\u00e4tsfalle \"", "Auslaufmodell Chef", "Mindestsicherung Wien : K\u00fcrzungen Sozialgeld", "Skispringen : Schlierenzauer 25 . November Schanze", "Liebevolle Familie Gesundheit \u00d6sterreicher gl\u00fccklich", "Experiment Selbstversorgung Michael Hartl : esse Gem\u00fcse Garten", "Bildungsreform : Wahlfreiheit Lehrern erstmals Noten Schulen", "Ellen DeGeneres kauft entz\u00fcckende Villa", "Mann X", "15 untr\u00fcgliche Zeichen Illuminati", "Witzig : Richard Lugner Sebastian", "Meinl-Reisinger : \" 2000 Klassen Wien \"", "Natalie Zettel : Fesche Cousine Kardashians Konkurrenz", "Moretti-Stier ( Stadt-)Flucht", "ABCSG-Studie : Antik\u00f6rper reduziert Risiko Knochenbr\u00fcche Brustkrebs", "Neos-Pl\u00e4ne Ebola-Zentrum", "Pop-Up-Lokale : Genuss-Trio , Betonk\u00fcche , Brandtners Mithridat , Naked Kitchen , Big Smoke", "Psychologie : Fehler Sch\u00fcler h\u00e4ufig Lernen", "  Weltstar Jos\u00e9 Feliciano : \" Blindheit \"", "Wiener SLAV-Gruppe : Mega-Pleite ukrainische Oligarchen", "Verteidiger Wiener Terrorverd\u00e4chtigen : \" Bombenbau entfernt \"", "Herzstillstand : \u00dcberlebenschance verdoppelt", "Klimts letzte Geheimnisse", "Urlaub Lohnerh\u00f6hung", "Feinspitz Kulinarik Komik", "Sommerfrische : Sieger ?", "Soko Donau : Seberg steigt , Steinocher", "Hoerbiger-Konzern : Abseits B\u00fchne", "Steigender Reichtum : 148.000 Million\u00e4re \u00d6sterreich", "Freizeitrose Kunsth\u00e4ndler Herbert Giese", "Lake Louise : Theaux Training Schnellste", "\u00c4rzte-Rebell", "GNTM-Fata : \" Freund nackt gesehen \"", "Doppelmord : Polizei \u201e geringste Spur \u201c", "E-Autos brauchen Starthilfe : Heuer 1222 Zulassungen", "\" Gestohlene Kindheit \" : Schauplatz Kinderheim", "\" Integrationsministerium \"", "Sabine Oberhauser Krebs : \" Tod ausblenden \"", "Flughafen Wien : \" Zehntausende Jobs wackeln \"", "Trump KGB Infos Clinton versorgt", "Alexander Pschill :   \" Abergl\u00e4ubisch , gl\u00e4ubig \u201c", "Start Zentralmatura : wichtigsten Fragen Antworten", "Unfallopfer Sahinovic : Hoffen First Lady", "Vordienstzeitenregelung \u00d6BB landet erneut EuGH", "Junger Manager \" alte Dame \"", "Michael Spindeleggers R\u00fccktrittsrede Wortlaut", "Missbrauch : Vorw\u00fcrfe Lehrer massiver", "Schauspielhaus : sch\u00f6n l\u00e4cheln , Lebenslauf-Optimierer", "Semotan & Kogelnik : System untergruben", "verbringen Handy ?", "Markterei Alten Post weicht Hotel Wohnungen", "Stella Rollig Direktorin Belvedere", "Heinz Fischers neues Leben Dachgescho\u00df Hofburg", "Modekette Stefanel", "Rewe testet Flatrate VIP-Kunden", "Kelly \u2019s erfindet superd\u00fcnne Gem\u00fcsechips", "Song Contest : heimischen Kandidaten", "Casper Wien : Maximaler Einsatz , Nuancierung Stimme", "139.000 Kilometer M\u00fcllhalde", "Strafnachlass Ernst Strasser : bekam strengen Richter :", "\" Elektra \" : Fahrstuhl Grauens", "Kinderwunsch , Kryokonservierung : Eizellen einfrieren biologische anhalten", "\" einfach Thomas Morgenstern \"", "M\u00f6glicherweise \u00d6sterreicher T\u00fcrkei festgenommen", "EU Migration Afrika umgehen", "Bernie Ecclestone verspottet Schwiegersohn James Stunt", "Hebamme : Jedes Mal emotional", "Auszug reibungslos klappt", "Heimische Justiz verschont Ost-Mafia", "Dorfmeisters Ex trotz Millionenpleite Casino : Antrag U-Haft", "Clubabend \u2013   Bausparer", "Salzburg : Job Sabine Breitwieser ausgeschrieben", "Personal Training Gruppe", "Medizin-Mythen : Wirkt Mutterkraut Migr\u00e4ne ?", "Telekom : Ermittlungen Martin Schlaff", "Hintergr\u00fcnde Pubers R\u00fcckkehr", "Pilz : \" geringsten Schuld bewusst \"", "Theraboxen", "Falsch verstanden : Top10 Song Verh\u00f6rer", "G\u00fcrtel-K\u00f6nig Anklagebank", "Kinder- Jugendpsychiatrie : Experten schlagen Alarm", "\" Wien Wiener \" : Georg Kreislers bissigste Zitate", "Arztpraxis ,", "Fischlokale Wien : Umar , Kornat , Fischviertel , Aurelius Konoba Pescaria", "Adventkalender Test", "Steirischer Herbst : Literaten kritisieren Brandl-Bestellung", "Burka-Verbot : Kanzler Christian Kern skeptisch", "Museum Bibel Washington er\u00f6ffnet", "Magermodels , ade : Gesetz regelt Mindestgewicht", "\u201e Rotlicht-Boss \u201c Richard Steiner bleibt Haft erspart", "Jus FH ? \" Schnapsidee \"", "Topsy K\u00fcppers : Leben Ungustl", "rechtsradikalen Mitl\u00e4ufer B\u00fcroleiter Hofers", "Kellyanne Conway : Trumps Beraterin kennt sexuelle Bel\u00e4stigung", "KBW-N\u00d6 : Luftballon-Blumen Zeitung", "USA : 35 Euro , Baby Geburt halten", "Silvio Nickol : Mutter schmeckt \u2019s", "Doskozil t\u00e4gliche Turnstunde \u00d6sterreich ausweiten", "Kundmanngasse : Zivilcourage lernt", "Standpunkt-Diskussion : , Gruppen , sehen !", "Nacktwandern : Textilfrei Bergen", "Wien : Montag startet Christbaumverkauf", "Handball : Fivers Heimsieg Graz punktegleich Leader Hard", "Autolegende Mustang : Wilde Pferde", "Mord Linz : Ermittlungsstand get\u00f6teten Ehepaar", "B\u00f6ller-Wettkampf Internet : Polizei warnt hohem Blutzoll", "Babybauch Frau innen w\u00f6lbte", "Motorsport : Rush-Darsteller Rennfahrer Sean Edwards verungl\u00fcckt", "Grazer Trauungssaal lesbische schwule Paare", "Cantina Osteria Friulana", "Therapie Apfelallergie", "Bedeutung Sparens \u00d6sterreich gestiegen", "BAWAG-Gro\u00dfaktion\u00e4r Cerberus steigt Deutscher Bank", "Promi-Doppelg\u00e4nger Social Media-Stars", "Susan Sarandon : Aff\u00e4re David Bowie", "Gast : Rustikal , regional lecker Gm\u00fcnd", "Albtraum Venedig", "LEBEN : Lebensweisheiten", "Sicherheitsleck Flughafen Schwechat aufgedeckt", "kalte Duschen f\u00fcrs Immunsystem ?", "Beauty-Marken \u00d6sterreich", "Fl\u00fcchtlinge : UNHCR appelliert Australien", "Millionen-Pleite Schuhhandels-Kette", "  Doppelhelix-Modell : Francis Crick James Watson entdeckten Struktur Erbguts", "Aiderbichl : Tierfreunde zahlen", "Arzt Diebesgut gekauft verh\u00f6kert", "Katalonien-Referendum : \" Ja\"-Lager gewinnt 90 Prozent Stimmen", "Paulus Hochgatterer : \" Angst Psychiater \"", "Tiersch\u00fctzer Adeligen : Richter brach Prozess", "Aufnahmetest : D\u00fcmmer Polizei erlaubt -   scheiterten Test", "Betrugsverdacht : Finanzaufsicht untersagt OneCoin Gesch\u00e4fte", "Neues Medikament verringert Sterberisiko 20 Prozent", "Reportage Erbil Irak - Flucht IS : \" zur\u00fcckgehen \"", "20 Fakten \" Hinterholz 8 \"", "Fl\u00fcchtlinge Wahlkampf : Schnappatmung \u00d6sterreich , Scheuklappen Deutschland", "Spieleagentin Herz", "Tom Cruise spricht erstmals Scientology", "Casual Dating , Casual Sex : Mann erz\u00e4hlt Erfahrungen", "Facebook-Pioniere warnen Social Media - sagen Experten", "Restaurants : Wien : Via Toledo : neapolitanische Pizzeria Josefstadt", "Trends 2017 : Dirndl heuer getragen", "Aktion scharf Uber-Fahrer Wien", "Gesundheitsserie : Einfach gesund 5L-Formel : Leben , Laufen , Lernen , Lieben Lachen", "Lokale offenem Kamin", "Interwetten sponsert SV Gr\u00f6dig", "\" Tod Ziel Lebensreise anerkennen \"", "Spitzenkandidaten beziehen Stellung Islam", "Kooperation Deradikalisierung", "Abgasskandal : VW sucht au\u00dfergerichtliche L\u00f6sungen frustrierten Kunden", "Neues Restaurant Meissl Schadn : Schnitzel Apfelstrudel Kaisers Zeiten", "Christa Kummer : Natur Stille Kraft-Tankstellen", "Austrian Anadi Bank : Neues Banken-Leben alten Gewand", "Missbrauch-Verfahren Volleyball-Trainer Wien delegiert", "Winde verwehte Royals : Schultag", "Naomi Watts & Billy Crudup : echten Leben Paar", "Toter Hausexplosion Hernals", "Johann Lafer : Frittatensuppe", "\" Most Wanted \" \u00d6sterreichs Kosovo festgenommen", "Pakt Teufel : 343 Stufen Stephansdom hinauf", "Protestbesuch Cuturi", "Zagreb : Korruptionsbek\u00e4mpfung Kroatien", ": 12 Fragen Schriftsteller Manfred Rebhandl", "Verm\u00f6gensberater Betrugsverdacht", "Salzburger Festspiele : \u2019s ekstatisch", "ORF-Show \" Echt ? ! \" : Stiefel reden fliegen lassen", "Missbrauch : betr\u00fcgen \u00c4rzte Patienten", "Kaiserschnitt Mutter verwehrt", "FP\u00d6-Mandatare tragen Edelwei\u00df Kornblume", "Verdacht Wettbetruges : \" tricksen UEFA \"", "Cameron Diaz : Wieso Barrymore & Paltrow Freundschaft k\u00fcndigt", "Vassilakou-Sympathisanten kontern", ": 7 Fragen SOKO-Donau Schauspieler Kabarettisten Gregor Seberg", "Bundesliga : Saison-Aus Rapids Christopher Dibon", "Laola1 \u00fcbergibt Willisits F\u00fchrungsverantwortung", "Kokainspur 2015", "6000 Patienten suchen Arzt", "Prozess \u00fcberrollten Arbeiter", "Autobahn-Vignette 2018 Kirschrot", "Gemischtes Doppel : Treffen Generationen", "Parteimitglieder : SP legt , \u00d6VP konstant", "Koh Phi Phi : \" The Beach \" Monate geschlossen", "Lost Dianne Yudelson : Fotoserie thematisiert Fehlgeburten", "G\u00f6tz George Alter 77 gestorben", "Werbeagabe - Kommunikationsbrache formiert Abschaffung", "Janosch : Tiger B\u00e4r Kindheitsh\u00f6lle Paradies", "18 Mio. Tonnen M\u00fcll Kanadas K\u00fcste", "Kinderleicht : Arme Ritter", "Infografik : Kunst , Bewerbungen pr\u00e4sentieren", "Online-Shops Test : Billa Merkur bestellen ?", "Burgenland : Hanfb\u00e4uerin Visier Justiz", "450 Millionen Dollar : Vinci-Gem\u00e4lde sprengt Rekorde", "400.000 Kinder \u00d6sterreich Armut betroffen - laut Statistik Austria", "\" Familie geh\u00f6rt hierher \"", "Franz Klammer : \" No amoi Streif ? I hob kan Vogel \"", "Top 5 : W\u00fcrstelst\u00e4nde Wien", "Jamaika gescheitert : Merkel Seehofer Klemme", "NR-Wahl : Kurz-Kabinettsmitarbeiter \" Strategiepapier \" mitgewirkt", "Mietnomaden : Albtraum Eigent\u00fcmer", "Pr\u00f6ll bildet Team : Mikl-Leitner Nachfolgerin positioniert", "Malia Obama : Harvard-Student Freund", "1000 \u00d6sterreicher vermisst", "Josip Cenic : Gitarrespieler Trsteno", "Staatsb\u00fcrgerschaft neu - T\u00fcren Reisepass", "Wahlkampf Shopping-Center : \" \u2019s Strache \"", "Gudenus : Preis Kopftuch-Emoji \" Irrsinn \"", "Inzestfall Amstetten : Fritzls Zellent\u00fcr tags\u00fcber", "Arabische TV-Serie zeigt Gr\u00e4uel IS", "Aussteiger : Stress Karriere", "Nutella : Rezeptur sorgt Aufregung", "\" leben \" : Wolfram Pirchner verl\u00e4sst ORF", "Ma\u00dflosigkeit Otto Muehl", "Ibiza : Schauspieler Heinz Marecek verr\u00e4t Hotspots Insel", "Arzt baut Haus alten Grabsteinen", "Giftk\u00f6der Wald Todesfalle", "Daily Show : Browser : Trumps Tweets Kinderschrift", "Soziologe Didier Eribon Pr\u00e4sident Emmanuel Macron : Pr\u00e4sident", "Russland : Wolgograd Stalingrad - Umbenennung Gedenken Schlacht", "Rapper Xatar : Schie\u00dferei Moderatorin Enissa Amani ?", "Werner Gruber : Wissenschaft \" alternative Fakten \"", "Monki , TK Maxx & Co. : 6 Stores Wien", "Pension Mehrkosten", "Neapolitaner b\u00e4ckt Bio-Pizza Veganer", "Jahrgang , schlimm", "Raub D\u00f6bling : \" Frau entf\u00fchren \"", "schlau \u00d6sterreichs Maturanten : Ergebnisse Zentralmatura 2017", "Streitgespr\u00e4ch uniko-Pr\u00e4sident Oliver Vitouch \u00d6H-Vorsitzende Lucia Grabetz : Uni-Zugang beschr\u00e4nkt ?", "Restaurants : Hauben-Gastronom d'Atri er\u00f6ffnet Trattoria Pulcinella Naschmarkt", "Sake Versuch wert", "Katie May : Playboymodel stirbt Besuch Chiropraktiker", "Abrissbirne Edelbordell", "Herbst 2017 : Jamie Oliver er\u00f6ffnet Lokal Wien", "\" Leben st\u00e4ndiger Angst B\u00e4r \"", "RFJ-Obmann \" Schweinskopf-Aff\u00e4re \" : \" handelt tats\u00e4chlich unseren \"", "tricksen Online-H\u00e4ndler Preis", "Richter Mord mitentscheiden", "\" Doctor 's Diary \" : 3 Staffeln", "Barbara Evans sch\u00f6nste Fu\u00dfballer-Freundin", "Larry Flynt : \" Hustler\"-Gr\u00fcnder 75", "regionale Headquarters ausl\u00e4ndischer Unternehmen", "gr\u00fcne Dorfidylle Stahlindustrie weichen", "Nutella 50", "Jugendlicher verschickte Nackt-Selfie verurteilt", "Liste Pilz \" Gr\u00fcn \"", "Route ? Hunderte Bootsfl\u00fcchtlinge Schwarzen Meer aufgegriffen", "1,4 Millionen Euro Tibet-Mastiff", "Schinkenmacher Gef\u00e4\u00dfchirurg", "\" Freies Spiel Kr\u00e4fte \" : langen Parlamentsnacht 2008 geschah", "Burger-Restaurants Wien", "Rekordhoch : Bitcoin stieg 8.000 Dollar", "Personalisiertes Impfen : \u00c4ra Impf-Strategie", "Uni FH : Welten", "Fl\u00fcchtlinge er\u00f6ffnen afghanisches Restaurant Asman 3 . Bezirk", "Wieso Prinzessin Dianas Nichte It-Girl", "Europarat : Fremdenhass \u00d6sterreich \" kultiviert \"", "entscheidet Laternen ?", "Nichtraucher klagen Abgeordnete", "Eventmanager Party Amtsschimmel", "Simma Leder & Schuh International-CEO", "Gro\u00dfmeister Zufalls", "Dave Kaufmann :   Fensterputzer Supertalent", "Dialekttagung : Wienerisch", "Moto3 : Kofler WM-Deb\u00fct starker Leistung", "Direktor Renner-Instituts Karl A. Duffek tot", "St. Margarethen : Oper Steinbruch 2018", "Besuch Eva Glawischnig : Hundefutter Fischjagd", "Goebel : \" liebt , uncool \"", "Preise beste mehrsprachige Jugendliche", "giftigsten Pflanzen Europas", "Beirat Wienwert ger\u00e4t Beschuss", "\" Alter Schwede \" : Lars Ruppel deutschsprachiger Poetry Slam Meister", "Jobwechsel Ehren  ", "\u00dcberh\u00f6hte Zinsen : 100.000 Frankenkredite betroffen", "Vorzeigeprojekt : Freunde Fremde", "Franz West Hawara", "Lottozahlen sch\u00fctteln", "Schmuck Trend 2015 : Palm Cuffs", "Pinkafeld : Christian Pfeiffer", "Oben-ohne-Badende Vergewaltigung bedroht : Verd\u00e4chtige", "Villen bringen Welterbe Gefahr", "Schule f\u00e4ngt", "Verh\u00fcllungsverbot : Schwere Zeiten Maskottchen", "15.000-Volt-Stromschlag Waggon", "Klagenfurt : Millionenprojekte liegen Eis", ": 10 Fragen S\u00e4nger Peter Kraus", "bittere Wahrheit Supermarkt-Oliven\u00f6le", "Lohndumping : Kritik Strafe Andritz-Chefs", "Tr\u00fcffel-Lokale : Gasthaus Schmutzer , Kussmaul , Bacco , Sopile , Procacci", "Transportwirtschaft sucht 4000 Lkw-Lenker", "Doping : Verurteilungen Freispr\u00fcche", "\u00d6sterreich Oktober Inflationsrate EU-Durchschnitt", "Treffpunkt Wien Drew Sarich : Richtige ( Jahres-)Zeit Pastrami", "Vegan-Experiment : Weihnachtsb\u00e4ckerei", "Las Vegas : Verk\u00fcndung Strafma\u00dfes deutschen Magier Rouven erneut verschoben", "Frankreich Lebensmittelverschwendung Kampf", "DieterBogner : \" Vertrag aufl\u00f6sen ! \"", "William Kate schotten London", "Maroni-Standln Test", "Elon Musk : Scheidung Frau Talulah Riley", "\" Maria \" : N\u00e4chster Hurrikan trifft karibischen Inseln", "Zentrum Begabte   Leistungsbereite Welt", "Karl-Renner-Preis Esther Mitterstieler", "Rauschendes Fest : ROMY-Gala 2016", "Hilfssheriffs Handy Jagd   Falschparker", "\" Talisman \" : Regietheater-Parodie Darm", "Hellboy : Unglaubliche Verwandlung David Harbour", "Global Cities Index : Wien verliert Platz", "Zahl Muslime w\u00e4chst rasant", "\" unvern\u00fcnftig Quadrat \"", "\" Knigge \" arabische G\u00e4ste Pinzgau : Where Cultures Meet", "Trafik Wien-Favoriten \u00fcberfallen : LPD Wien fahndet unbekannten T\u00e4tern", "EU-Verordnung : Br\u00fcssel rudert Saatgut", "Salcher : \" vorbildliche Schulen \"", "Reportage Ukraine : \" Kiew Teufel scheren \"", "Aufgesp\u00fcrt : Doppel-Staatsb\u00fcrger", "Valentinstag : Restaurants : Wien : Silvio Nickol Clementine : Coburg tischt Prunkr\u00e4umen", "\u00d6sterreich : Land jugendlichen Raucher", "Werbung : \" stehe Namen \"", "dran Steuer-Wunderland Schweiz ?", "Steirische Turbinen \u00c4gypten", "F\u00fcnfj\u00e4hrige vergewaltigt : Festnahme", "Chelsea Handler provoziert Sex-Tweet Melania Trump", "\u00d6BB schaffen 101 \" Cityjet\"-Z\u00fcge 590 Mio. Euro", "Kopftuch-Verbot l\u00f6st Kopfsch\u00fctteln", "Microsoft relauncht MSN.com", "Neuer Chef Festival Wien Modern gefunden", "Halloween : Donald Trump jagt Kindern Angst", "Schadstoffbelastung Dieselskandal : 80 Todesf\u00e4lle j\u00e4hrlich \u00d6sterreich", "Heuriger Wieninger : Schatten Nussb\u00e4ume", "Holz Beton : Kompromiss", "Internetsucht Jugendlichen nimmt", "Lauda betrogen : 9 Haft Manager", "Nutella krebserregend", "Pressestunde : Kern \" runter Gas \"", "Paradise Papers : Schwarze Liste schwarze Schafe", "Besuch Supermarkt Zukunft", "Zechner Neidgesellschaft \u00d6sterreich", "Drogenkrieg Mexiko : Kartellen , Kokain Kriegsgebieten", "Gedenken Attentat Oberwart 20", "Schicksalsschlag : \" Samuel K\u00e4mpfer \"", "Restaurantkritik Heurigen Muth D\u00f6bling", "USA bereiten Pr\u00e4ventiv-Angriff Nordkorea", "Bloody Mary 2013 Cocktails Meistermixern", "Strafverteidiger : \" Verbrechen bezahlt \"", "Generation Egoisten", "Wien : Kosmetikmarke Aesop er\u00f6ffnet Store", "Wiener Juice Factory-Gastronomen kontern Venedigs B\u00fcrgermeister", "Punschh\u00e4ferln Goldgrube Diebesbanden", "Mozart Salieri : Gegenspieler , Kollegen", "Besuch Starkls", "Sparsamkeit Luxus Top-Platz", "\" einfach fassungslos \"", "Kreuzfahrt : Ticket Elbphilharmonie", "Schlafmangel - Folgen L\u00f6sungen : 10 Fakten Schlaf", "Meghan Markle Bruder erz\u00e4hlt Prinz Harry", "Stars , Klauen erwischt", "Chris Pratt dick Hollywood", "Ozzy Osbourne : Jahrelanges Doppelleben gef\u00fchrt ?", "Palliativmedizin : Hilfe Extremsituation", "Megan Fox Ver\u00e4nderung Beauty-OPs Botox", "Sebastian : Wende-Kanzler", "Burgtheater : Neuer Stellvertreter kaufm\u00e4nnischen Gesch\u00e4ftsf\u00fchrer", "Konrad \u00d6VP-FP\u00d6 : \" Sicher Wunschregierung \"", "Eisenbahner Bergbau : Hohe Zusch\u00fcsse , niedrige Effizienz", "Wien : Halloween-Feier sorgte Polizeieinsatz", "Moretti & Blo\u00e9b : Br\u00fcder entdecken neu", "Feriendomizile : \" System Scheinheiligkeit \"", "Casinos Austria sondieren Interesse Auslandstochter CAI", "Wissen , Haus wert ?", "Andreas Schieder Wiener B\u00fcrgermeister", "Ski alpin : wartet Hirscher Challenge Riesentorlauf", "\" Fluchtbranche \" Gastronomie", "Wunderwelt Indien : M\u00e4rchenhaftes Rajasthan", "St. P\u00f6lten : Hacker legte Kulturbetrieb lahm", "US-Wahl : Trump Jr. Kontakt Wikileaks", "Collier \" \" kostet Ferrari", "USA - Land begrenzten M\u00f6glichkeiten", "Augen Doppel-Agent Franco Foda", "Sondierungsgespr\u00e4che : Zeiten , alte Rituale", "Polizei suchte M\u00f6rder Museum", "Gr\u00fcner Stadtrat gr\u00fcne Spitze Parteischulden Kasse bitten", "  Liste \" Atid \" Oskar Deutsch gewinnen Kultusratswahl", "\" weite Land \" falschen Film", "Floatfit : Schwitzen Wasser", "Polizei ver\u00e4rgert : Laserblocker Autoh\u00e4ndler", "\u00d6FB-Trainingslager : Speed-Dating Franco Foda", "IKG-Chef Deutsch : \" Deutschnationale Regierung verloren . \"", "Sundt : Manipulation \" gewusst \"", "Feuerwehrpr\u00e4sident Albert Kern : Ehrenamt", "Erziehungstipps : Familienstress adieu - 10 Schritten Lernerfolg", "Penisl\u00e4nge : Forscher ermittelten Durchschnitt", "Perrie Edwards : Foto OP-Narbe wichtig", "Johann Lafer : Krautroulade", "  Verstecktes Risiko Bauch : Aorta platzen", "Meghan Markle : Fotos hei\u00dfer Hochzeit Strand aufgetaucht", "b\u00e4ckt Vanillekipferl ?", "Amal Clooney & Cindy Crawford : coolsten Halloween-Kost\u00fcme 2017", "Ernst August Hannover : Streit Sohn August junior \u00fcberschattet Hochzeit", "Folter , Vergewaltigung V\u00f6lkermord : brutalsten Herrscher Afrikas", "Marcos Nader : \" voll angreifen \"", "AMS-Schulungen lukratives Gesch\u00e4ft", "WM-Quali : \u00d6FB-Damen Pflichtsieg Israel", "Dubiose Steueroasen : Schwarze Liste schwarze Schafe", "Dirk Stermann Vater Sohnes ?", "Plan K : Schul-Evolution", "Ernst Happel : Unberechenbar voraus", "S\u00e4ugling Spital gestorben : Kindsvater sitzt U-Haft", "Henning Baum : packt Frau Corinna", "Zusammenbruch : Heather Locklear Entzug", "Neues Steak-Restaurant El Gaucho er\u00f6ffnet Rochusmarkt", "Diabetes : Schichtarbeit erh\u00f6ht Risiko deutlich", "Zentralmatura : bleibt K\u00fcr ?", "Kritik : Google Maps l\u00f6scht Kalorienz\u00e4hler", "Mutprobe : Todessprung Reichsbr\u00fccke", "Afrika lebt Fl\u00fcchtlingen", "Pflegeskandal : Vorw\u00fcrfe Beh\u00f6rde", "Nacktbaden Rio : FKK Playa do Abrico offiziell erlaubt", "\" American Sniper \" : Lebenslange Haft T\u00f6tung US-Scharfsch\u00fctzen Chris Kyle", "Heidi Strobl : Gef\u00fcllter K\u00fcrbis", "10 Superfoods , Ihren Speiseplan einbauen", "Deutsches Verfassungsgericht fordert Eintrag Geschlecht", "Polt : \" kokettiere   Missverst\u00e4ndnissen \"", "Deutschland : K\u00f6ln st\u00fcrzt tiefer Krise", "Brandanschlag Facebook-Liebe", "Alexander Pschill : Durststrecken", "Ober\u00f6sterreich : Max & Andi spurlos verschwunden", "Erben Streit : Letzte Wille Erf\u00fcllung", "Gewerbeordnung : Widerstand wirkliche Reform", "\u00d6sterreich : Mehrheit kennt \" soziale Marktwirtschaft \"", "Aromatherapie : \u00c4therische \u00d6le : heilende Kraft Aromen", "Peter Cornelius : Opa & John Lennon", "Modebloggerin Chiara Ferragni schwanger", "Johann Lafer : Topfentorte", "Haus mehrere Eigent\u00fcmer", "Vorschreibung herabsetzen ?", "T\u00f6dliche Selfies Spanien : Baby-Delfin gestorben", "Handtaschen l\u00e4sst Geld verdienen", "Afrikaner st\u00fcrmten spanische Exklave Ceuta : 70 Verletzte", "Sharing Economy : Teilen n\u00fctzt", "Schande Charlottesville", "Manfred Haimbuchner : \u201e Rand aufr\u00e4umen \u201c", "Jugendforschung : Generation Nesthocker", "Tipps Wetterf\u00fchligkeit F\u00f6hn , Kopfschmerzen Migr\u00e4ne", "Trinkgeld Reisen : \" Stimmt \" stimmt", "Renate-Welsh-Lesung : Gespr\u00e4che Kindern", "Neuer Eigent\u00fcmer , Regeln ?", "Armut lebt \u00d6sterreich", "Setzer Wiff !", "U6 Dealer : L\u00f6sung ,", "James Bond : sch\u00f6nsten Drehorte \u00d6sterreich", "Schwerverletzte Todesopfer B\u00f6ller", "Franz Hubmann : Leben Fotografie", "Marilyn Manson : Depressionen Trennung", "Karl Merkatz : Erinnerungen", "Sternsinger Heilige K\u00f6nige : wichtigsten Fragen", "M\u00fctterschulen : M\u00fctter Kampf Radikalisierung Wien", "Soziale Medien Kulturproblem", "Nieder\u00f6sterreich : Kult-Hotel steht", "Studie Verkehrsclub \u00d6sterreich : Zahl Verkehrstoten nimmt starkab", "YouTube : Eugen Freund Wahlvideo Van Bellen", "Kanzler Kern Vize Mitterlehner Interview : \" Trump-Partei \u00d6sterreich \"", "Herd Christa Kummer", "Weihnachtbeleuchtung Nachbarn st\u00f6rt , ?", "Trumps M\u00e4nner , angeklagt h\u00e4uslicher Gewalt", "Slopestyle : Kurs FIS IOC", "Stinkefinger-Bild M\u00e4hdrescher : ATV-Star angezeigt", "Sexy Pamela sch\u00fcchtern", "20 Rohrbombe Theo Kelz", "Magna-Chef : Selbstfahrende Autos \" gr\u00fcnere \" Zukunft", "Lkw-Blockabfertigung Tirol : Schaltet Bayern EU ?", "Gesamtschule : gemeinsam lernen", "Tr\u00fcffel Wienerwald", "Rebellen Ablaufdatum", "FP\u00d6-Politiker Johann \u00dcberbacher blamiert \" Russia Today\"-Interview", "Seisenbacher : Auslieferung scheint unwahrscheinlich", "Ranking : h\u00e4ufigsten Krebsarten \u00d6sterreich", "\" Galerie \" New York plant Ausstellung \" entarteter Kunst \"", "Negativzinsen : Raiffeisenbanken Zinsen zur\u00fcckzahlen", "Giganten-Eisberg :   \" System Gleichgewicht \"", "Bundesliga : Oliver Lederer neuer Trainer St. P\u00f6lten", "Geigerin Lidia Baich erwartet Baby", "Au\u00dfenwerbe-Branche launcht Outofhome.at", "Missbrauch Jugendstrafvollzug : Volksanwaltschaft pr\u00fcfen , Karl verteidigt Zust\u00e4nde", "Familienbeihilfe : ernst K\u00fcrzung Ausland", "Alt Wien Patina", "Habsburger Abdankung Exil", "Schuhrebell \u201e Friedensangebot \u201c", "Wirtschaftswachstum \u00d6sterreich : Bank Austria rechnet Prozent", "Samuel Koch Sarah Elena Timpe heimlich geheiratet", "Gebraucht-Haus : Pr\u00fcfe , ewig bindet", "Paris Hilton : kocht ihren Austro-Million\u00e4r Thomas", "M\u00f6dling : Kardiologie-Schwerpunkt verlegt", "Kapellmeister Nazis", "Kates Bruder : Sorgenkind Middletons", "\u00d6sterreich dritth\u00f6chste Diesel-Pkw-Dichte EU", "Tr\u00fcgerische Bilanz Mordf\u00e4llen", "Welt-Aids-Tag : wichtigsten Fragen Antworten HIV", "B\u00f6gerl : Abschiedsbrief Satz", "Verwalter Reparaturr\u00fccklage sorgen ?", "Gewinner Verlierer : Globalisierung reich", "App : My Measures & Dimensions sammelt Abmessungen", "Restaurierung : Wiener Staatsoper neuem Glanz", "Lohnschere : \u00d6sterreich Europa Vorletzter", "Angeline Jolie : \" Privat v\u00f6llig \"", "Neuer Chef Bawag PSK", "Weg Ziel", "2017 deutlich Abschiebungen", "Wachauer Marillen : Heuer rar teuer", "Staat Kinder abnimmt", "Urteil Italien : Sofia Mutter bleiben", "\" Don Carlo \" : einzigartiges Finale Tenor Roberto Alagna", "Tod Ottakring : Firmenchef Explosion ermordet", "Heinrich Himmer : \" Schulen sozialen Brennpunkten \"", "\" Ariadne Naxos \" Wiener Staatsoper : Triumph", "Europol sucht Verbrecher per Adventkalender", "Kleinwalsertal ger\u00e4t   Fokus deutschen Fiskus", "Fahrstil Magazin \u00d6sterreich", "Land kippt Pflegeregress Behinderte", "Freizeitoption : 5 Urlaub 2 Prozent Gehalt", "Gesetzes\u00e4nderung : Waffenp\u00e4sse Polizisten", "letzte Habsburg-R\u00e4tsel : \" Fall Pachmann \"", "Austria-Trainer Hrubesch Daxbacher", "leisen Reifen : E-Autos Gefahr", "Barbara Prammer : \" l\u00e4uft Film \"", "Klein , fein : Buchhandlung Kurt Lhotzky", "Beyonce : \" Kindheit geopfert \"", "Steyr-Panzerwerk steht", "Kaviar-Produktion verdoppelt", "Plakat-Serie Hofburg-Wahl : Alexander Van Bellen \" \u00d6sterreich dienen \"", "Haubenkoch , vegan ern\u00e4hrt", "perfekte Grundriss", "Medizin-Mythen : Gerstengras gesund ?", "Karge Antwort Justizministerin Anfragen Objekt 21", "Wohnung zusammenlegen teilen", "Kraft Muskeln", "Europaparlament Warn-Etiketten Alkohol-Getr\u00e4nken , Schwangere Autofahrer richten", "Streitfall : Bausparkassen k\u00fcndigen teure Altvertr\u00e4ge", "Wahlplakate : Bilder", "\" S\u00fcdseek\u00f6nig \" \" Negerk\u00f6nig \"", "Schmucker Schutz : Ungewohnte Fassaden", "Ariana Grande : Beauty-OP", "Vollbesch\u00e4ftigung ?", "Hodler Leopold Museum : Maler Liebe Tod", "Vergewaltigungs-Vorw\u00fcrfe Islam-Professor", "KTM-Boss Pierer SP\u00d6 klagen , Rote legen", "Punsch ans Christkind", "Autozubeh\u00f6rkette Forstinger Erholungskurs", "Eva-Maria Burger : Unterschriftensammlerin Pr\u00e4sidentin", "Julius Detektive", "Donald Trump unbeliebte Modelagentur", "Michelle Obama zeigt erstmals nat\u00fcrliche Haare", "Pilzsaison : Giftige Schwammerl Lupe", "sex FREIZEIT : Gabriele Kuhn", "Bildungsreform : K\u00fcndigungsschutz Lehrer gelockert", "\" Mama singt Geschenke \" : Verr\u00fccktes Spiel G\u00e4nsehaut-Gesang", "H\u00e4user Durchatmen Wohlf\u00fchlen", "AKH Wien : Chefs \u00d6sterreichs gr\u00f6\u00dftes Krankenhaus", "privater Verwalter ?", "UNICEF-Studie : \u00d6sterreich Kinder", "Priester Gerhard H\u00f6berth Familie : \" Priester Kinder \"", "Billig-Jobs Fl\u00fcchtlinge : Pro & Contra", "Glutenarme Ern\u00e4hrung : Negativ Gesundheit ?", "Restaurants : Wien : Bros . : Topfen Beinschinken : Pizza \u00f6sterreichisch", "Wien : U4 f\u00e4hrt Osterwochenende Schottenring", "Wiener Weinh\u00e4ndler \" Just Taste \" pleite", "Fertighausfirma Zenker k\u00fcndigt 90 Mitarbeiter", "Armut : \" sch\u00e4men anfangs \"", "Oe24.tv : Kobuk factcheckt Fellner-Moderation", "Sepp Schellhorn K\u00f6che-Mangel : \" Branche schlechtgemacht \"", "dayli-Pleite : Erstmals Geld Gl\u00e4ubiger", "Dr. Universalgenie ermittelt", "Michael Ludwig : \" starte Wohnbauoffensive \"", "Twitter : Quinn Gee : , Partner psychisch krank ?", "Meinl Sohn Julius Meinl VI . feiert Luxus-Hochzeit Olivia Stolt-Nielsen Holten", "Rap-Messias Donaustadt : Yung Hurns neues Video Blume", "Blick Edvard Munch", "wartet G\u00fcnther Jauch", "Whistleblowing : Helfer Kampf Korruption", "Fu\u00dfball : L\u00e4nderspiel \u00d6sterreich-Uruguay - 10.000 Karten verkauft", "Haider-B\u00fcndnis h\u00e4ngt Seilen", "FeetUp", "Erwin Wurms Biennale-Eyecatcher", "Schulkinder , zwangsfotografiert", "Wunderwimpern Wien", "sch\u00e4dlich Sitzen \u00fcberkreuzten Beinen ?", "Staatsdiener : langsame Vertreibung Paradies", "TCM : Suppe Reis-Congee Lebensenergie hebt", "Dramaturgin Ursula Voss 67-j\u00e4hrig gestorben", "Interview Sportalm-Designerin Ulli : sieht perfekte Dirndl", "Signal Beitrittsgespr\u00e4che", "Gerhard K\u00f6fer \" Koalition \u2019s kriseln \"", "\" Sparw\u00fctige Ahnungslosigkeit \"", "Wien : 47-J\u00e4hriger bedrohte Kellnerin Schreckschusspistole", "klein Star . Promis", "Angebliche Kryptow\u00e4hrung OneCoin : Staatsanwalt St. P\u00f6lten ermittelt", "US-Polizeisirenen \u00d6sterreich ?", "Lehrlinge kochen Fl\u00fcchtlinge", "Asyl - Fl\u00fcchtlinge : arbeiten \u2013", "Great Wall Motors : Chinesischer Autoriese errichtet Forschungszentrum \u00d6sterreich", "Todesfall Thailand : passiert Kontakt W\u00fcrfelqualle", "entkommt Pablo Escobar", "Birgit Reitbauer : Chefin Laden schupft", "Jugendstrafvollzug : Fragezeichen Reformversprechen", "Trump-Schwiegersohn Kushner Finanzspritze 500 Millionen Dollar Katar", "Auslieferung \" Austro-Terrorist \" Mohamed Mahmoud beantragt", "versuchter Vergewaltigung : Asylwerber verurteilt", "Secret Hitler : Brettspiel hebt Trump", "Scheidungskind Wohnsitze", "Salzburg : Gr\u00fcnder sch\u00e4tzen urbanes Flair", "Interventionsw\u00fcrfe BMI-Beamte : Ermittlungen eingestellt", "Investmentbanker Michael Treichl Brand festgenommen", "Cybermobbing : \" d\u00fcmmste Sau 3A ? \"", "Peter Handke reist \" Obstdiebin \"", "Semmering : Schlafende Sch\u00f6nheit", "Jedes Haus Schwarzbau", "Ingrid Betancourt : lebt Ex-Geisel", "Weinselig Jeruzalem", "verdienen Schlagerstars", "Lehrer Professor ? Junge Gr\u00fcne Titel abschaffen", "Neues Buch Renate Daimler", "Tipps Tricks Matura", "F\u00fcnfer Zeugnis : Fleck weg ! ?", "Studie : \u00d6sterreich wirft jedes 760.000 Tonnen Lebensmittel weg", "Agenda Austria : Denkfabrik Million\u00e4re", "Palais Coburg : Weltbeste Weinauswahl Wiens 20 Millionen-Keller", "Ober\u00f6sterreich/Tschechien : M\u00e4dchen CO-Vergiftung erstickt", "Mut Ver\u00e4nderung", "Wirtschaftskammer Wien : Neuer Vorsto\u00df Infrastruktur-Holding", "Psychiater Goldwater-Regel : Debatte Geisteszustand Trump", "Begr\u00fcnte D\u00e4cher : Garten", "Verh\u00fctung : Hoffnung M\u00e4nner-Pille", "Br\u00fcndlmayer : Sir Winzern", "L\u00e4nderkammer letzte gr\u00fcne Bastion", "TV-Moderatorin Annemarie Carpendale schwanger", "Restaurants Weihnachten Silvester", "Jamie 's Italian \u00fcbernimmt Lokal Wiener Innenstadt", "Canicross : Schnelles Laufen Hund liegt Trend", "Kindergarten-Chef \u2005 klagt \" Islamisten-J\u00e4ger \" D\u00f6nmez", "Kollege , Liebster", "2 Standorte Wien : Fast schaffte Matura", "FP\u00d6-Kampagne : Strache Scheidungshelfer", "Social-Media-Studie : negativen Effekte Facebook-Likes", "Laura Bilgeri : Vorarlbergerin erobert Hollywood", "Melania Trump : Emp\u00f6rung Vanity Fair Cover Mexiko", "Bianca Schwarzjirg : Morddrohungen Witz alte", "Otto Klambauer : Abschied unserem Geschichtslehrer", "Jubil\u00e4ums-H\u00f6hepunkte 2015", "Digitale Revolution :   r\u00fcsten . .", "Weltrekord Lassnig-Bilder Mal geknackt", "Yoga : \u00dcberraschende Wirkungsweise entdeckt", "Massimo Bottura : Italiens bester Koch", "Witzigmanns Welt : Sulmtaler Hendl", "\" Ugly Krems \" : Tour schmerzhaften Baus\u00fcnden", "Weihnachts-Schmuck gl\u00fccklich", "Armes Schwein : Greenpeace-Kritik Supermarkt-Angebot", "Studie : Social Media dumm", "Robbie Williams lag Intensivstation", "Chiara Pisati : Karibik-Urlaub Patrick Kunst", "\" Lagom \" : richtige Ma\u00df Zufriedenheit", "Fleischkonsum zerst\u00f6rt Welt", "Gault&Millau 2017 : Haubenkoch Obauer klagt B\u00fcrokratie", "Verein Konsumentenschutz : Katzenfutter Test", "Eva P\u00f6lzl Pius Strobl getrennt", "Beloved Shirts : Badeanz\u00fcge behaarter M\u00e4nnerbrust", "\u00d6sterreich verbietet Onlinehandel E-Zigaretten", "\u00dcberforderte Eltern : , Kind Nerven verliert ?", "Kr\u00e4utern steckt : Entdecken Kraft !", "Kabarettist Andreas Vit\u00e1sek feiert 60er", "Udo Kier folgt Gert Voss Schalko-Projekt", "VfGH : Bank Austria Pensionisten 790 Mio. Euro nachzahlen", "Klein- Mittelbetriebe erhalten F\u00f6rderung schnelles Internet", "Salz & Pfeffer : Concordia Schl\u00f6ssl", "Ehemalige Ski-L\u00e4uferin erz\u00e4hlt sexueller Bel\u00e4stigung", "Dodgeball Amerika gespielt", "Nachbarn get\u00f6tet : Verst\u00e4rkte Polizeistreifen", "Annemarie Moser-Pr\u00f6ll feierte ihren 60er", "\" Dorf Stadt \"", "Cheftrainer Damen J\u00fcrgen Kriechbaum Interview : \" Damen reagieren sensibler \"", "Trinken : Bitte , durstig", "Norbert Blecha liebt Ursula Andress  ", "Bhut-Jolokia-Chili : Mann \u00e4tzt Loch Speiser\u00f6hre", "Komitee Gerhard Haderer , Franz Fischler , Othmar Karas Ferdinand Lacina wirbt Alexander van Bellen", "Gault-Millau : beste \u00f6sterreichische Edelbrand pr\u00e4miert", "Arzt liebt Miss : sch\u00f6nste Paar Welt ?", "Deutsches Start-up Jacky F. Jackfrucht \u00d6sterreich verkaufen", "Amy Winehouse : Ex Blake Fielder-Civil spricht erstmals Mitschuld Tod", "Chlo\u00e8 Bartoli : Star-Stylistin verr\u00e4t 3 wichtigsten Kleidungsst\u00fccke", "Weg Regierung : M\u00f6gliche Szenarien", "Bulgarien - \" Jedes Kind unserem Land arm \"", "Auslands\u00fcberweisungen : BIC ben\u00f6tigt", "ges\u00fcndeste Alkohol Welt", "Illegale Zweit-P\u00e4sse : Doppelte Staatsb\u00fcrger enttarnen", "Blogger : Schattenseiten Internet-Ruhms", "Artikel 1", "Jamaika : wichtigsten Fragen Antworten", "Derby : Sportchefs Doppelinterview", "Essen Schule", "Carl Philip Sofia : Nachwuchs schwedischen K\u00f6nigshaus", "Restaurants : Ausflugs-Gasthaus Mirli", "Kindern Wahlkampf kindisch", "French Open live : Thiem - Goffin", "Trennung Vadim Garbuzov & Kathrin Menzinger"]}}; }
plotInterface = buildViz(1000,600,null,null,false,false,false,false,false,true,false,false,true,0.1,false,undefined,undefined,getDataAndInfo(),true,false,null,null,null,null,true,false,true,false,null,null,10,null,null,null,false,true,true,undefined,null,false);
</script>
