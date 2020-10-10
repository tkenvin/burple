using System;
using System.Collections.Generic;
using System.Drawing;

namespace curtains
{
    sealed class XkcdColour
    {
        private XkcdColour(string name, string value)
        {
            Name = name;
            Value = value;
        }

        public string Name { get; private set; }

        public string Value { get; private set; }

        private Color _colour;
        private Color Colour
        {
            get
            {
                if (_colour == Color.Empty)
                {
                    _colour = ColorTranslator.FromHtml(Value);
                }
                return _colour;
            }
        }

        public int Proximity(string value)
        {
            var other = new XkcdColour("user input", value);
            return Proximity(other);
        }

        private int Proximity(XkcdColour other)
        {
            var redDiff = Math.Abs(this.Colour.R - other.Colour.R);
            var greenDiff = Math.Abs(this.Colour.G - other.Colour.G);
            var blueDiff = Math.Abs(this.Colour.B - other.Colour.B);
            return redDiff + greenDiff + blueDiff;
        }

        #region static colours
    {{range $key, $value := .}}
        public static readonly XkcdColour {{camel $key}} = new XkcdColour("{{$key}}", "{{$value}}");
    {{end}}
        #endregion
        
        #region  all colours enumerable
        public static readonly ISet<XkcdColour> AllColours = new HashSet<XkcdColour>
        {
        {{- range $key, $value := .}}
            {{camel $key -}},
        {{- end}}
        };
        #endregion
    }
}
