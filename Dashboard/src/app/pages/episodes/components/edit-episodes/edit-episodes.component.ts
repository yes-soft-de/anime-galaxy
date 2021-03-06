import { DatePipe, formatDate } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs';
import { map, mergeMap } from 'rxjs/operators';
import { HelperService } from 'src/app/@theme/helper/helper.service';
import { AnimesResponse } from 'src/app/pages/animes/entity/animes-response';
import { AnimeService } from 'src/app/pages/animes/services/anime.service';
import { ImageSnippet } from 'src/app/pages/categories/entity/image-snippet';
import { ListCategoryResponse } from 'src/app/pages/categories/entity/list-category-response';
import { CategoryService } from 'src/app/pages/categories/services/category.service';
import { EditEpisode } from '../../entity/edit-episode';
import { EditEpisodeResponse } from '../../entity/edit-episode-response';
import { EpisodesService } from '../../services/episodes.service';

@Component({
  selector: 'app-edit-episodes',
  templateUrl: './edit-episodes.component.html',
  providers: [DatePipe]
})
export class EditEpisodesComponent implements OnInit {
  episodeID: number;
  mergeResult: {
    animes: AnimesResponse
    categories: ListCategoryResponse,
  }
  episodesData: EditEpisode;
  isSubmitted = false;
  uploadForm: FormGroup;
  uploadButtonValue = 'Upload';
  imageName = 'Leave it if you don\'t want to change image';
  fileSelected = false;
  imageUrl: string;
  imagePathReady = true;
  submitButtonValue = 'Update Episode';
  selectedFile: ImageSnippet;

  constructor(private episodeService: EpisodesService,
              private animeService: AnimeService,
              private categoryService: CategoryService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private datePipe: DatePipe,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }



  ngOnInit() {
  

    this.episodeID = parseInt(this.activatedRoute.snapshot.paramMap.get('id'));
    this.episodeService.getEpisode(this.episodeID).subscribe(
     (episodeResponse: EditEpisodeResponse) => {
        this.episodesData = episodeResponse.Data;
        this.updateFormValues();
      }
    );


    const animes: Observable<AnimesResponse> = this.animeService.allAnimes();
    const categories: Observable<ListCategoryResponse> = this.categoryService.allCategories();
    const result: Observable<any> = animes.pipe(
      mergeMap(animesResponse => {
        return categories.pipe(
          map(categoriesResponse => {
            const result = {
              animes: animesResponse,
              categories: categoriesResponse
            };
            return result;
        }))
      })
    );
    result.subscribe(
      mergeResponse => {
        this.mergeResult = mergeResponse;
      }
    );

    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      animeID: ['', Validators.required],
      categoyID: ['', Validators.required],
      seasonNumber: ['', [Validators.required, Validators.minLength(1)]],
      episodeNumber: ['', [Validators.required, Validators.minLength(1)]],
      description: ['', Validators.required],
      image: [''],
      duration: ['', Validators.required],
      publishDate: ['', Validators.required]
    });
  }


  
// Fill Form Input 
updateFormValues() {
  this.uploadForm.patchValue({    // Insert Our category Data Into Form Fields
    animeID: this.episodesData.animeID,       // we must use the id not the name to make relate with select html tag
    categoyID: this.episodesData.categoryID,
    seasonNumber: this.episodesData.seasonNumber,
    episodeNumber: this.episodesData.episodeNumber,
    description: this.episodesData.description,
    image: this.episodesData.image,
    duration: HelperService.convertSecondsToHMS(this.episodesData.duration.timestamp),
    publishDate: this.datePipe.transform(new Date(this.episodesData.publishDate?.timestamp * 1000), 'yyyy-MM-dd'),
  });
}

  // Choose Anime Using Select Dropdown
  changeAnime(event) {
    this.uploadForm.get('animeID').setValue(event.target.value, {
      onlySelf: true
    });
  }

  // Choose Category Using Select Dropdown
  changeCategory(event) {
    this.uploadForm.get('categoyID').setValue(event.target.value, {
      onlySelf : true
    });
  }


  // Get Image Information
  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  // Upload Image
  processFile(imageInput: any) {
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();
    
    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'Update Episode';          
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      // formObject.suggest = this.uploadForm.value.suggest == 1 ? true : false;
      formObject.id = this.episodeID;
      if (this.imageUrl) {
        formObject.image = this.imageUrl;
      } else {
        formObject.image = this.episodesData.imageURL;
      }
      this.episodeService.updateEpisode(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.router.navigate(['../../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }

}
