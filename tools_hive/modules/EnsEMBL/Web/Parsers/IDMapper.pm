=head1 LICENSE

Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut

package EnsEMBL::Web::Parsers::IDMapper;

use strict;
use warnings;

use EnsEMBL::Web::Utils::FileHandler qw(file_get_contents);

sub new {
  my ($class, $runnable) = @_;
  return bless { 'runnable'  => $runnable }, $class;
}

sub parse {
  my ($self, $file) = @_;

  my @results = map {'old' => $_->[0], 'new' => $_->[1], 'release' => $_->[2], 'score' => $_->[3]}, grep { $_->[0] && $_->[0] ne 'Old stable ID' } file_get_contents($file, sub {
    return [ map s/^\s+|\s+$//gr, split ',', $_ ];
  });

  return \@results;
}

1;