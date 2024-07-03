# hook.command_not_found
$env.config = ($env.config | upsert hooks.command_not_found {|config|
    let val = ($config | get -i hooks.command_not_found)
    let did_you_mean = {$env.NU_EXTERNAL | path join nu_scripts/nu-hooks/nu-hooks/command_not_found/did_you_mean.nu | open}

    if $val == null {
        $val | append $did_you_mean
    } else {
        [
            $val
            $did_you_mean
        ]
    }
})
