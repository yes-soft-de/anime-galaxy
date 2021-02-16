import { Component, OnInit } from '@angular/core';

import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Animes } from 'src/app/pages/animes/entity/animes';
import { AnimesResponse } from 'src/app/pages/animes/entity/animes-response';
import { AnimeService } from 'src/app/pages/animes/services/anime.service';
import { SuggestService } from '../../services/suggest.service';

@Component({
  selector: 'app-edit-suggest',
  templateUrl: './edit-suggest.component.html'
})
export class EditSuggestComponent implements OnInit {


  animes: Animes[];
  isSubmitted = false;
  uploadForm: FormGroup;


  constructor(private animeService: AnimeService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService) {
  }

  ngOnInit() {

    this.animeService.allAnimes().subscribe(
      (animesResponse: AnimesResponse) => {
        if (animesResponse) {
          this.animes = animesResponse.Data;
        }
      }
    );


    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      animeID: ['', Validators.required],
      animeSuggest: ['', Validators.required]
    });
  }

  // Choose Anime Using Select Dropdown
  changeAnime(event) {
    this.uploadForm.get('animeID').setValue(event.target.value, {
      onlySelf: true
    });
  }

  // Choose Category Using Select Dropdown
  changeSuggest(event) {
    this.uploadForm.get('animeSuggest').setValue(event.target.value, {
      onlySelf : true
    });
  }


  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      this.isSubmitted = false;
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      formObject.animeSuggest = this.uploadForm.value.animeSuggest == 1 ? true : false;

      console.log(formObject);
      // this.suggestService.animeSuggest(formObject.animeID, formObject.suggest).subscribe(
      //   (createResponse: any) => console.log(createResponse),
      //   error => {
      //     this.isSubmitted = false;
      //     console.log('Error : ', error);
      //   },
      //   () => {
      //     this.router.navigate(['../'], {relativeTo: this.activatedRoute});
      //   }
      // );
    }
  }

}
