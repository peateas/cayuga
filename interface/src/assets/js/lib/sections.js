import $ from 'jquery';

class Section {
    constructor(position) {
        this.position = position;
        this.sources = {};
    }

    get selector() {
        let short = this.tag;
        if (this.class != null) short += `.${this.class}`;
        return `.page-on>${short}`;
    }

    get tag() {
        return 'main';
    }

    get class() {
        return null;
    }

    get area_tag() {
        return 'article';
    }

    get area_class() {
        return null;
    }

    area_name(name) {
        return `${this.position}-area-${name}`;
    }

    area_selector(name) {
        return `${this.selector}>${this.area_tag}#${this.area_name(name)}`;
    }

    add(name, source) {
        this.sources[name] = source;
        let tag = this.area_tag;
        let klass = this.area_class;
        let id = this.area_name(name);
        if ($(`#${id}`).length !== 0) return;

        let area = $(`<${tag} id="${id}"></>`);
        if (klass != null) area.addClass(klass);

        $(this.selector).append(area);
    }

    update(name) {
        $.ajax(this.sources[name], {
            dataType: "json",
            context: this.area_selector(name)
        })
            .done(function (result) {
                    let items = [];
                    $.each(result, function (key, value) {
                        items.push("<li>" + value + "</li>");
                    });
                    $("<ul></ul>", {
                        html: items.join("")
                    }).appendTo($(this));
                }
            )
            .fail(function (xhr, status, error) {
                console.log("Result: " + status + " " + error + " " + xhr.status + " " + xhr.statusText);
            });
    }
}

class Aside extends Section {
    constructor(position) {
        super(position)
    }

    get tag() {
        return 'div';
    }

    get class() {
        return this.position;
    }

    get area_tag() {
        return 'aside';
    }

    get area_class() {
        return 'area-on'
    }

    get area_class_off() {
        return `${this.position}-area-off`
    }

    area_name(name) {
        return `${super.area_name(name)}-on`
    }

    area_name_off(name) {
        return `${super.area_name(name)}-off`
    }

    area_selector_off(name) {
        return `${this.area_tag}#${this.area_name_off(name)}`;
    }

    button_name(name) {
        return `${this.position}-button-${name}`;
    }

    add(name, source) {
        super.add(name, source);
        let tag = this.area_tag;
        let klass = this.area_class_off;
        let id = this.button_name(name);
        let off = this.area_name_off(name);
        let button = `<div><button class="${tag}" id="${id}" data-open="${off}"></button></div>`;
        let nav = `${this.selector}>nav`;
        $(nav).append($(button));
        let spot = this.position;
        let area = `<${tag} class="${klass} position-${spot}" id="${off}" data-off-canvas></${tag}>`;
        $('body').append($(area));
    }

    update(name){
        super.update(name);
        $.ajax(this.sources[name], {
            dataType: "json",
            context: this.area_selector_off(name)
        })
            .done(function (result) {
                    let items = [];
                    $.each(result, function (key, value) {
                        items.push("<li>" + value + "</li>");
                    });
                    $("<ul></ul>", {
                        html: items.join("")
                    }).appendTo($(this));
                }
            )
            .fail(function (xhr, status, error) {
                console.log("Result: " + status + " " + error + " " + xhr.status + " " + xhr.statusText);
            });
    }
}

export const section_main = new Section('main');
export const section_left = new Aside('left');
export const section_right = new Aside('right');