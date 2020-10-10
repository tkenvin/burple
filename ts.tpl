export class XkcdColour {
    private readonly _name: string;
    private readonly _value: string;
    private readonly _red: number;
    private readonly _green: number;
    private readonly _blue: number;

    public get name(): string {
        return this._name;
    }

    public get value(): string {
        return this._value;
    }

    private constructor(name: string, value: string) {
        this._name = name;
        this._value = value;
        this._red = parseInt(value.substring(1, 3), 16)
        this._green = parseInt(value.substring(3, 5), 16)
        this._blue = parseInt(value.substring(5), 16)
    }

    private _proximity(other: XkcdColour): number {
        const redDiff = Math.abs(this._red - other._red);
        const greenDiff = Math.abs(this._green - other._green);
        const blueDiff = Math.abs(this._blue - other._blue);
        return redDiff + greenDiff + blueDiff;
    }
    
    public proximity(v: string): number {
        var other = new XkcdColour("user input", v);
        return this._proximity(other);
    }
//#region static colours
{{range $key, $value := .}}
    public static {{camel $key}}: XkcdColour = new XkcdColour("{{$key}}", "{{$value}}");
{{end}}
//#endregion

//#region  all colours enumerable
    public static AllColours: ReadonlyArray<XkcdColour> = [
    {{- range $key, $value := .}}
        XkcdColour.{{camel $key -}},
    {{- end}}
    ];
//#endregion
}
