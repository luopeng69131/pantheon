#!/usr/bin/env python2

from os import path
from subprocess import check_call

import arg_parser
import context


def main():
    args = arg_parser.sender_first()

    cc_repo = path.join(context.third_party_dir, 'gail')
    send_src = path.join(cc_repo, 'run_sender.py')
    recv_src = path.join(cc_repo, 'stable_custom/stable_env/indigo_env/env/run_receiver.py')
    
    requirments_path = path.join(cc_repo, 'requirements.txt')
    if args.option == 'setup':
        check_call(['pip3 install -r %s' % requirments_path], shell=True)
        return

    if args.option == 'sender':
        cmd = ['python3', send_src, args.port]
        check_call(cmd)
        return

    if args.option == 'receiver':
        cmd = ['python3', recv_src, args.ip, args.port, '-1', '0', '0']
        check_call(cmd)
        return



if __name__ == '__main__':
    main()