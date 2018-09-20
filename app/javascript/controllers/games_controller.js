import { Controller } from "stimulus";

export default class extends Controller {

    initialize() {
        console.log('Initialized games controller');
    }

    showModal(e) {
        let someElement = $('.modal-dialog')[0];
        let event = new CustomEvent('show', { bubbles: true, cancelable: true });
        event.data = { id: e.target.dataset.id, title: e.target.dataset.title };
        someElement.dispatchEvent(event);
    }
}