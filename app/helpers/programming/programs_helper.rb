module Programming::ProgramsHelper

	def status_label(status)
		codes = {
			mem:     'label-important',
			cpu:     'label-important',
			hang:    'label-warning',
			sig:     'label-warning',
			ok:      'label-success',
			exit:    'label-warning',
			compile: 'label-warning',
			fail:    'label-important'
		}
		'label ' << codes[status.downcase.to_sym]
	end

end
