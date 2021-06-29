/**
 * TDS Password Toggle
 *   - Finds all elements starting with the class `tds-form-item--password`
 *     and attaches an event listener to the toggle button found within
 */
const passwordInputs = document.querySelectorAll('.tds-form-item--password');

passwordInputs.forEach((formItem) => {
  const input = formItem.querySelector('.tds-text-input[type="password"]');
  const button = formItem.querySelector('.tds-password-input--toggle');
  const btnIcon = button.querySelector('svg > use');
  const showLabel = formItem.dataset.showlabel;
  const hideLabel = formItem.dataset.hidelabel;
  const showIcon = `#${formItem.dataset.showicon}`;
  const hideIcon = `#${formItem.dataset.hideicon}`;
  const btnTitle = button.querySelector('svg > title');
  const visbilityClass = 'tds--is_invisible';

  // Toggle class on an element
  function toggleButtonVisibility(e, cls) {
    return input.value.length > 0 ? e.classList.remove(cls) : e.classList.add(cls);
  }

  if (input) {
    toggleButtonVisibility(button, visbilityClass);
    input.onkeyup = () => {
      toggleButtonVisibility(button, visbilityClass);
    };
    input.onfocus = () => {
      toggleButtonVisibility(button, visbilityClass);
    };
    input.onblur = () => {
      toggleButtonVisibility(button, visbilityClass);
    };
  }

  /**
   * If there's a button, within this password wrapper, let's proceed.
   */
  if (button) {
    button.addEventListener('click', () => {
      let btnIconHref = btnIcon.getAttribute('xlink:href');

      /**
       * Toggle the input type from password to text and visa versa so the
       * user can check to see if they entered their password correctly.
       */
      input.type = input.type === 'password' ? 'text' : 'password';

      /**
       * Provide flexibility to customers who want custom messaging as well as be
       * friendly towards localization efforts downstream from TDS.
       *
       * First, check to see if there are values for customized Labels. If there
       * are, let's use them. If there are not, provide a logical fallback.
       *
       * Next, let's check to see if there are values for customizing the icon
       * set. If there are, we should use those as well. If there are not, provide
       * a sensible icon.
       *
       * NOTE: the sensible fallback assumes the TDS SVG Spritesheet is installed
       * and available on the same page as the password field.
       */
      if (showLabel && hideLabel) {
        btnTitle.innerHTML = btnTitle.innerHTML === showLabel ? hideLabel : showLabel;
      } else {
        btnTitle.innerHTML =
          btnTitle.innerHTML === 'Show Password' ? 'Hide Password' : 'Show Password';
      }

      if (showIcon && hideIcon) {
        btnIconHref = btnIconHref === showIcon ? hideIcon : showIcon;
      } else {
        btnIconHref = btnIconHref === '#tds-eye-hide' ? '#tds-eye-show' : '#tds-eye-hide';
      }
      btnIcon.setAttribute('xlink:href', btnIconHref);
    });
  }
});
