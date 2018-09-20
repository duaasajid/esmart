import { Controller } from "stimulus";

export default class extends Controller {

    static targets = ['modal', 'title', 'form', 'handle', 'errorMsg'];

    initialize() {
        console.log('Initialized modal controller');
    }

    show(e) {
        this.titleTarget.textContent = e.data.title;
        this.formTarget.action = `/games/${e.data.id}/add`;
        $(this.modalTarget).modal('show');
    }

    success() {
        location.reload(true);
    }

    error(e) {
        let msg = e.detail[0]['errors'].join(', ');
        $(this.handleTarget).addClass('is-invalid');
        $(this.errorMsgTarget).html(msg).removeClass('d-none');
    }

}
