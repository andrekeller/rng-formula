rngd:
  pkg.installed:
    - pkgs:
      - rng-tools
  service.running:
    - name: rngd.service
    - enable: True
  file.managed:
    - name: /etc/conf.d/rngd
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://rng/files/rngd.conf
    - watch_in:
      - service: rngd

{% if salt['pillar.get']('truerng', False) %}
truerng:
  file.managed:
    - name: /etc/udev/rules.d/99-TrueRNG.rules
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://rng/files/99-TrueRNG.rules
{% endif %}
